#
# invoke: pytest -vv sbz_laptop.py --connection=ssh --hosts=kakato,192.168.1.45
#

import unittest
import platform

from testinfra import host


def test_passwd_file(host):
    passwd = host.file("/etc/passwd")
    assert passwd.contains("sbz")
    assert passwd.user == "root"
    assert passwd.group == "wheel"
    assert passwd.mode == 0o644


def test_packages_are_installed(host):
    packages = ('git', 'ltrace', 'python', 'rxvt-unicode', 'vim')
    for pkg in packages:
        p = host.package(pkg)
        assert p.is_installed


@unittest.skipIf(platform.machine(), 'amd64')
def test_strace_is_installed(host):
    strace = host.package("strace")
    assert strace.is_installed


def test_cpu(host):
    cpu_model = host.sysctl('hw.model')
    assert 'intel' in cpu_model.lower()


def test_n_cpu(host):
    ncpu = host.sysctl('hw.ncpu')
    assert ncpu == 4


def test_physmem(host):
    def mem_in_gb(value):
        import math

        mem = (value / 10**9.0)
        return math.trunc(mem)

    physmem = host.sysctl('hw.physmem')
    assert mem_in_gb(physmem) > 4
    assert mem_in_gb(physmem) == 8
