#!/bin/bash
set -e

# Get and prepare nvml source
./prepare.sh

# Build all and run tests
cd nvml
make -j2 dpkg
