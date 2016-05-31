#!/bin/bash
set -e

# Get and prepare nvml source
./prepare.sh

# Build all and run tests
cd nvml
make check-license && make cstyle && make -j2 USE_LIBUNWIND=1 && make -j2 test USE_LIBUNWIND=1 && make check && make DESTDIR=/tmp source

