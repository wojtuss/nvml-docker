#!/bin/bash
set -e

# Mount filesystem for ?
echo 'nvmlpass' | sudo -S mount -t tmpfs none /tmp -osize=4G

# Get nvml source
git clone https://github.com/pmem/nvml.git
cd nvml

# Configure tests
echo 'vnmlpass' | sudo -S service ssh start
cp ../configure_tests.sh .
./configure_tests.sh
rm -f configure_tests.sh

