import json
import pathlib
import string

import pytest
from pytest_bdd import scenario, then, parsers, when
import testinfra
import kubernetes as k8s
import yaml

from tests import utils

# Scenarios
@scenario('../features/expansion.feature',
          'Add one node to the cluster',
          strict_gherkin=False)
def test_cluster_expansion(host):
    pass

# Fixtures {{{

@pytest.fixture
def ssh_config(request):
    return request.config.getoption('--ssh-config')

# }}}
# When {{{

@when(parsers.parse('we declare a new "{node_type}" node on host "{hostname}"'))
def declare_node(
    ssh_config, version, k8s_client, node_type, hostname, bootstrap_config
):
    """Declare the given node in Kubernetes."""
    node_ip = get_node_ip(hostname, ssh_config, bootstrap_config)
    node_name = utils.resolve_hostname(hostname, ssh_config)
    node_manifest = get_node_manifest(
        node_type, version, node_ip, node_name
    )
    k8s_client.create_node(body=node_from_manifest(node_manifest))


@when(parsers.parse('we deploy the node "{name}"'))
def deploy_node(host, ssh_config, version, name):
    node_name = utils.resolve_hostname(name, ssh_config)
    accept_ssh_key = [
        'salt-ssh', '-i', node_name, 'test.ping', '--roster=kubernetes'
    ]
    pillar = {'orchestrate': {'node_name': node_name}}
    deploy = [
        'salt-run', 'state.orchestrate', 'metalk8s.orchestrate.deploy_node',
        'saltenv=metalk8s-{}'.format(version),
        "pillar='{}'".format(json.dumps(pillar))
    ]
    run_salt_command(host, accept_ssh_key, ssh_config)
    run_salt_command(host, deploy, ssh_config)


# }}}
# Then {{{

@then(parsers.parse('node "{hostname}" is registered in Kubernetes'))
def check_node_is_registered(ssh_config, k8s_client, hostname):
    """Check if the given node is registered in Kubernetes."""
    node_name = utils.resolve_hostname(hostname, ssh_config)
    try:
        k8s_client.read_node(node_name)
    except k8s.client.rest.ApiException as exn:
        pytest.fail(str(exn))


@then(parsers.parse('node "{hostname}" status is "{expected_status}"'))
def check_node_status(ssh_config, k8s_client, hostname, expected_status):
    """Check if the given node has the expected status."""
    node_name = utils.resolve_hostname(hostname, ssh_config)
    try:
        status = k8s_client.read_node_status(node_name).status
    except k8s.client.rest.ApiException as exn:
        pytest.fail(str(exn))
    # If really not ready, status may not have been pushed yet.
    if status.conditions is None:
        assert expected_status == 'NotReady'
        return
    # See https://kubernetes.io/docs/concepts/architecture/nodes/#condition
    MAP_STATUS = {'True': 'Ready', 'False': 'NotReady', 'Unknown': 'Unknown'}
    for condition in status.conditions:
        if condition.type == 'Ready':
            break
    assert MAP_STATUS[condition.status] == expected_status


@then(parsers.parse('node "{node_name}" is a member of etcd cluster'))
def check_etcd_role(ssh_config, k8s_client, node_name):
    """Check if the given node is a member of the etcd cluster."""
    node_name = utils.resolve_hostname(node_name, ssh_config)
    etcd_member_list = etcdctl(k8s_client, ['member', 'list'], ssh_config)
    assert node_name in etcd_member_list, \
        'node {} is not part of the etcd cluster'.format(node_name)


# }}}
# Helpers {{{

def kubectl_exec(
    host,
    command,
    pod,
    kubeconfig='/etc/kubernetes/admin.conf',
    **kwargs
):
    """Grab the return code from a `kubectl exec`"""
    kube_args = ['--kubeconfig', kubeconfig]

    if kwargs.get('container'):
        kube_args.extend(['-c', kwargs.get('container')])
    if kwargs.get('namespace'):
        kube_args.extend(['-n', kwargs.get('namespace')])

    kubectl_cmd_tplt = 'kubectl exec {} {} -- {}'

    with host.sudo():
        output = host.run(
            kubectl_cmd_tplt.format(
                pod,
                ' '.join(kube_args),
                ' '.join(command)
            )
        )
        return output

def get_node_ip(hostname, ssh_config, bootstrap_config):
    """Return the IP of the node `hostname`.
    We have to jump through hoops because `testinfra` does not provide a simple
    way to get this information…
    """
    infra_node = testinfra.get_host(hostname, ssh_config=ssh_config)
    control_plane_cidr = bootstrap_config['networks']['controlPlane']
    return utils.get_ip_from_cidr(infra_node, control_plane_cidr)

def get_node_manifest(node_type, metalk8s_version, node_ip, node_name):
    """Return the YAML to declare a node with the specified IP."""
    filename = '{}-node.yaml.tpl'.format(node_type)
    filepath = (pathlib.Path(__file__)/'..'/'files'/filename).resolve()
    manifest = filepath.read_text(encoding='utf-8')
    return string.Template(manifest).substitute(
        metalk8s_version=metalk8s_version, node_ip=node_ip, node_name=node_name
    )

def node_from_manifest(manifest):
    """Create V1Node object from a YAML manifest."""
    manifest = yaml.safe_load(manifest)
    manifest['api_version'] = manifest.pop('apiVersion')
    return k8s.client.V1Node(**manifest)

def run_salt_command(host, command, ssh_config):
    """Run a command inside the salt-master container."""

    pod = 'salt-master-{}'.format(
        utils.resolve_hostname('bootstrap', ssh_config)
    )

    output = kubectl_exec(
        host,
        command,
        pod,
        container='salt-master',
        namespace='kube-system'
    )

    assert output.exit_status == 0, \
        'deploy failed with: \nout: {}\nerr:'.format(
            output.stdout,
            output.stderr
        )

def etcdctl(k8s_client, command, ssh_config):
    """Run an etcdctl command inside the etcd container."""
    name = 'etcd-{}'.format(
        utils.resolve_hostname('bootstrap', ssh_config)
    )
    etcd_command = [
        'etcdctl',
        '--endpoints', 'https://localhost:2379',
        '--ca-file', '/etc/kubernetes/pki/etcd/ca.crt',
        '--key-file', '/etc/kubernetes/pki/etcd/server.key',
        '--cert-file', '/etc/kubernetes/pki/etcd/server.crt',
    ] + command
    output = k8s.stream.stream(
        k8s_client.connect_get_namespaced_pod_exec,
        name=name, namespace='kube-system',
        command=etcd_command,
        stderr=True, stdin=False, stdout=True, tty=False
    )
    return output

# }}}
