# freebsd-ansible-config

[Ansible][1] rules to (re)install your FreeBSD laptop or server **[in progress]**.

Requirements
============

This make use of [Ansible][1] project. You need to install it with the following
command:

```
    sudo pkg install -y ansible
```

Usage
=====

* Laptop deployment

In order to run it, you need to use `bootstrap.sh` script and launch
`ansible-playbook` command with privileged user as below:

```
    sudo ./bootstrap.sh
    ansible-playbook -b -k -u $USER -v playbooks/laptop.yml
```

* Server deployment

```
    ansible-playbook -v -l server playbooks/server.yml --ssh-extra-args="-A"
```

Goal
====

The goal is to be able to have a reproducible and idempotent installation.

FAQ
===

The laptop deployment use no SSH key, it should be run after your operating 
system installation procedure.

[1]: https://www.ansible.com
