# freebsd-ansible-config

[Ansible][1] rules to (re)install your FreeBSD desktop/laptop **[in progress]**.

Requirements
============

This use [Ansible][1] project. You need to install it with the following
command:

```
    sudo pkg install -y ansible
```

Usage
=====

In order to run it, you need to use `bootstrap.sh` script and launch
`ansible-playbook` command with privileged user as below:

```
    sudo ./bootstrap.sh
    sudo ansible-playbook -s -k -u $USER -v main.yml
```

Goal
====

The goal is to be able to have a reproducible and idempotent installation.

FAQ
===

This voluntary use no SSH key, it should be run after your operating system 
installation procedure.

[1]: https://www.ansible.com
