#!/bin/sh

export ASSUME_ALWAYS_YES='true'
export PKG='/usr/local/sbin/pkg'

# disable ssh client hostkey check
export ANSIBLE_HOST_KEY_CHECKING='False'

# bootstrap pkg
/usr/sbin/pkg bootstrap
$PKG update
$PKG upgrade
$PKG audit -Fq

# bootstrap requirements
$PKG install \
    devel/py-pip \
    sysutils/ansible \
    security/openssh-askpass \
    security/sshpass \
    shells/bash

# configure inventory
[ ! -d /usr/local/etc/ansible ] && mkdir -p /usr/local/etc/ansible
if [ ! -f /usr/local/etc/ansible/hosts ]; then
    cp /usr/local/share/examples/ansible/ansible.cfg /usr/local/etc/ansible/ansible.cfg
    cat <<EOF > /usr/local/etc/ansible/hosts
[freebsd]
`hostname -f`

[freebsd:vars]
ansible_python_interpreter=/usr/local/bin/python2
EOF

    sed -i.old 's,^#\(inventory.*\),\1,p' /usr/local/etc/ansible/ansible.cfg
else
    cp /usr/local/etc/ansible/hosts /usr/local/etc/ansible/hosts.old
fi

# configure filter plugin
[ ! -d /usr/local/share/ansible/plugins/filter ] && mkdir -p /usr/local/share/ansible/plugins/filter
    cp plugins/filter/pkg_exclude.py /usr/local/share/ansible/plugins/filter/

# list target hosts
ansible --list-hosts all

echo "[*] Run ansible-playbook now!"
echo " > sudo ansible-playbook -b -k -u $SUDO_USER -v playbooks/laptop.yml"

# ping hosts
ansible all -m ping -b -k -u $SUDO_USER
