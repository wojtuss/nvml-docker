#!/bin/bash
set -e

# Configure tests
cat << EOF > src/test/testconfig.sh
NON_PMEM_FS_DIR=/tmp
PMEM_FS_DIR=/tmp
PMEM_FS_DIR_FORCE_PMEM=1
EOF

# Configure remote tests
if [[ $REMOTE_TESTS -eq 1 ]]; then
	echo "Configuring remote tests"
	cat << EOF >> src/test/testconfig.sh
NODE[0]=127.0.0.1
NODE_WORKING_DIR[0]=/tmp/node0
NODE_ADDR[0]=127.0.0.1
NODE[1]=127.0.0.1
NODE_WORKING_DIR[1]=/tmp/node1
NODE_ADDR[1]=127.0.0.1
EOF

	mkdir -p ~/.ssh/cm

	cat << EOF >> ~/.ssh/config
Host 127.0.0.1
	StrictHostKeyChecking no
	ControlPath ~/.ssh/cm/%r@%h:%p
	ControlMaster auto
	ControlPersist 10m
EOF

	ssh-keygen -t rsa -C $USER@$HOSTNAME -P '' -f ~/.ssh/id_rsa
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
	ssh 127.0.0.1 exit 0
else
	echo "Skipping remote tests"
fi

