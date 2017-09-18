import platform

from ansible import errors

'''
Ansible filter plugin to exclude some packages according architectures
    cf. http://docs.ansible.com/ansible/latest/playbooks_filters.html
'''

# few packages are not publicly available yet on some architectures.
excluded_arch_pkgs = {
    'amd64': ['strace']
}


def pkg_exclude(pkg):
    arch = platform.machine()
    if arch in excluded_arch_pkgs:
        try:
            for excluded in excluded_arch_pkgs.get(arch):
                pkg.remove(excluded)
        except ValueError:
            raise errors.AnsibleFilterError(
                "{0} not found in list {1}".format(excluded, pkg))

    return pkg


class FilterModule(object):
    ''' Ansible core jinja2 filters '''

    filter_map = {
        'pkg_exclude': pkg_exclude,
    }

    def filters(self):
        return self.filter_map
