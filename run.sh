#!/bin/bash
set -e

imageName=nvml/ubuntu:16.04
containerName=nvml-ubuntu-16.04

if [[ $CC == "clang" ]]; then export CXX="clang++"; else export CXX="g++"; fi
if [[ $MAKE_DPKG -eq 0 ]] ; then command="/bin/bash ./make.sh"; fi
if [[ $MAKE_DPKG -eq 1 ]] ; then command="/bin/bash ./make_dpkg.sh"; fi

if [ -n "$http_proxy" ]; then RUN_OPTIONS=" $RUN_OPTIONS --env http_proxy=$http_proxy "; fi
if [ -n "$https_proxy" ]; then RUN_OPTIONS=" $RUN_OPTIONS --env https_proxy=$https_proxy "; fi

docker run --rm --privileged=true --dns=172.28.168.170 --name=$containerName -ti \
	$RUN_OPTIONS \
	--env CC=$CC \
	--env CXX=$CXX \
	--env EXTRA_CFLAGS=$EXTRA_CFLAGS \
	--env MAKE_DPKG=$MAKE_DPKG \
	--env REMOTE_TESTS=$REMOTE_TESTS \
	$imageName $command

