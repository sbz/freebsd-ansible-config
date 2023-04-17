#!/bin/sh

[ -f ./facts ] && rm ./facts
hostname=`hostname`

cat <<'EOF' > reduce.jq
def pick($paths): 
  . as $root | reduce $paths[] as $path ({}; . + { ($path): $root[$path] }); 

 .ansible_facts | pick(["ansible_kernel", "ansible_architecture", "ansible_distribution", "ansible_kernel_version"])
EOF

ansible -m setup localhost | sed '1 s/^.*|.*=>.*$/{/g' | jq -f reduce.jq

echo -e "## auto generated with: \$ ansible -k -b -m setup ${hostname}" | tee ./facts
ansible -k -b -m setup ${hostname} | tee -a ./facts

rm -rf reduce.jq
