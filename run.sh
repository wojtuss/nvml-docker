#!/bin/bash
set -e

imageName=wojtuss/nvml-ubuntu1604:1
containerName=nvml-ubuntu1604

if [ "$CC" = "clang" ]; then export CXX="clang++"; else export CXX="g++"; fi
if [[ $MAKE_DPKG -eq 0 ]] ; then command="/bin/bash ./make.sh"; fi
if [[ $MAKE_DPKG -eq 1 ]] ; then command="/bin/bash ./make_dpkg.sh"; fi
echo $command

docker run --rm --privileged=true --dns=172.28.168.170 --name=$containerName -ti \
	--env http_proxy=$http_proxy \
	--env https_proxy=$https_proxy \
	--env CC=$CC \
	--env CXX=$CXX \
	--env EXTRA_CFLAGS=$EXTRA_CFLAGS \
	--env MAKE_DPKG=$MAKE_DPKG \
	--env REMOTE_TESTS=$REMOTE_TESTS \
	$imageName /bin/bash
	#$imageName $command

