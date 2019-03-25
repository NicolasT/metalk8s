# coding: utf-8


"""Useful global constants, used hither and yon."""


import os
from pathlib import Path
from typing import Tuple

from buildchain import ROOT  # Re-export ROOT through this module.
from buildchain import config


# Max length of a "command".
# (used in task display, for a nice aligned output).
CMD_WIDTH : int = 12

# URLs of the main container repositories.
GOOGLE_REGISTRY : str = 'k8s.gcr.io'
DOCKER_REGISTRY : str = 'docker.io/library'

# Paths {{{

# Root of the generated ISO.
ISO_ROOT : Path = config.BUILD_ROOT/'root'
# Root of the repositories on the ISO.
REPO_ROOT : Path = ISO_ROOT/'packages'
# Root for the packages that we build ourselves.
PKG_ROOT : Path = config.BUILD_ROOT/'packages'

# }}}
# Container options {{{

BIND_RO_MOUNT_FMT : str = 'type=bind,source={src},destination={dst},ro'
BUILDER_RPMLINTRC_MOUNT : str = BIND_RO_MOUNT_FMT.format(
    src=ROOT/'packages'/'rpmlintrc',
    dst='/rpmbuild/rpmlintrc'
)
BUILDER_ENTRYPOINT_MOUNT : str = BIND_RO_MOUNT_FMT.format(
    src=ROOT/'packages'/'entrypoint.sh',
    dst='/entrypoint.sh'
)
BUILDER_BASIC_CMD : Tuple[str, ...] = (
    config.DOCKER, 'run',
    '--env', 'TARGET_UID={}'.format(os.geteuid()),
    '--env', 'TARGET_GID={}'.format(os.getegid()),
    '--hostname', 'build',
    '--mount', 'type=tmpfs,destination=/tmp',
    '--mount', BUILDER_ENTRYPOINT_MOUNT,
    '--rm',
)

# }}}
# Versions {{{

K8S_VERSION  : str = '1.12.6'
SALT_VERSION : str = '2018.3.3'


def load_version_information() -> None:
    """Load version information from `VERSION`."""
    to_update = {
        'VERSION_MAJOR', 'VERSION_MINOR', 'VERSION_PATCH', 'VERSION_SUFFIX'
    }
    with VERSION_FILE.open('r', encoding='utf-8') as fp:
        for line in fp:
            name, _, value = line.strip().partition('=')
            # Don't overwrite random variables by trusting an external file.
            var = name.strip()
            if var in to_update:
                globals()[var] = value.strip()


VERSION_FILE : Path= ROOT/'VERSION'

# Metalk8s version.
# (Those declarations are not mandatory, but they help pylint and mypy).
VERSION_MAJOR  : str
VERSION_MINOR  : str
VERSION_PATCH  : str
VERSION_SUFFIX : str

load_version_information()

SHORT_VERSION : str = '{}.{}'.format(VERSION_MAJOR, VERSION_MINOR)
VERSION : str = '{}.{}{}'.format(SHORT_VERSION, VERSION_PATCH, VERSION_SUFFIX)

# }}}