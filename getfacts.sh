#!/bin/sh

[ -f ./facts ] && rm ./facts
hostname=`hostname`

echo -e "## auto generated with: \$ sudo ansible -k -s -m setup ${hostname}" | tee ./facts
sudo ansible -k -s -m setup ${hostname} | tee -a ./facts
