#!/bin/bash
set -e

mount -t tmpfs none /tmp -osize=4G

# Get nvml source
git clone https://github.com/wojtuss/nvml.git
pushd nvml

# Configure tests
cp ../configure_tests.sh .
./configure_tests.sh
rm -f configure_tests.sh

# Build all and run tests
make -j2 dpkg
