#!/bin/sh

[ -f ./facts ] && rm ./facts
hostname=`hostname`

echo -e "## auto generated with: \$ ansible -k -b -m setup ${hostname}" | tee ./facts
ansible -k -b -m setup ${hostname} | tee -a ./facts
