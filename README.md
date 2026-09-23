# freebsd-ansible-config

[Ansible][1] rules to (re)install your FreeBSD laptop or server.

Requirements
============

This make use of [Ansible][1] project. You need to install it with the following
command:

```
    sudo pkg install -y sysutils/ansible
```

Usage
=====

* Laptop deployment

In order to run it, you need to use `bootstrap.sh` script and launch
`ansible-playbook` command with privileged user as below:

```
    sudo ./bootstrap.sh
    sudo ansible-playbook -b -k -u $USER -v playbooks/laptop.yml
```

* Server deployment

```
    sudo ansible-playbook -v -l server playbooks/server.yml --ssh-extra-args="-A"
```

Specification tests
===================

Tests are implemented using the Infrastructure test framework [testinfra][2]

We could verify our installation is conformed by launching the spec tests:

```
    tests/runtests.sh
```

Goal
====

The goal is to be able to have a reproducible and idempotent installation.

FAQ
===

The laptop deployment use no SSH key, it should be run after your operating 
system installation procedure.

[1]: https://www.ansible.com
[2]: https://testinfra.readthedocs.io
