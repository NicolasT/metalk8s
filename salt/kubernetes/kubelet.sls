Install CRI infrastructure:
  pkg.installed:
    - sources:
      - cri-tools: http://rpmfind.net/linux/fedora/linux/releases/29/Everything/x86_64/os/Packages/c/cri-tools-1.11.0-2.dev.git19b7255.fc29.x86_64.rpm
      - runc: https://rpmfind.net/linux/fedora/linux/updates/29/Everything/x86_64/Packages/r/runc-1.0.0-66.dev.gitbbb17ef.fc29.x86_64.rpm
      - container-selinux: https://rpmfind.net/linux/fedora/linux/updates/29/Everything/x86_64/Packages/c/container-selinux-2.77-1.git2c57a17.fc29.noarch.rpm
      - containerd: http://rpmfind.net/linux/fedora/linux/updates/testing/29/Everything/x86_64/Packages/c/containerd-1.2.1-1.fc29.x86_64.rpm

Configure Kubernetes repository:
  pkgrepo.managed:
    - humanname: Kubernetes
    - name: kubernetes
    - baseurl: https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
    - gpgcheck: 1
    - repo_gpgcheck: 1
    - gpgkey: https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
    - enabled: 0

Install kubelet dependencies:
  pkg.installed:
    - pkgs:
      - ebtables
      - socat

Install kubelet:
  pkg.installed:
    - fromrepo: kubernetes
    - pkgs:
      - kubelet
