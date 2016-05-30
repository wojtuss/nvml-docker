#!/bin/bash
set -e

mount -t tmpfs none /tmp -osize=4G

# Get nvml source
git clone https://github.com/pmem/nvml.git
pushd nvml

# Configure tests
cp ../configure_tests.sh .
./configure_tests.sh
rm -f configure_tests.sh

# Build all and run tests
make check-license && make cstyle && make -j2 USE_LIBUNWIND=1 && make -j2 test USE_LIBUNWIND=1 && make check && make DESTDIR=/tmp source

