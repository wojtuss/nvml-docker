#!/bin/bash -e
#
# Copyright 2014-2016, Intel Corporation
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in
#       the documentation and/or other materials provided with the
#       distribution.
#
#     * Neither the name of the copyright holder nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

imageName=nvml/ubuntu:16.04
containerName=nvml-ubuntu-16.04

if [[ $CC == "clang" ]]; then export CXX="clang++"; else export CXX="g++"; fi
if [[ $MAKE_DPKG -eq 0 ]] ; then command="/bin/bash ./run-build.sh"; fi
if [[ $MAKE_DPKG -eq 1 ]] ; then command="/bin/bash ./run-build-package.sh"; fi

if [ -n "$http_proxy" ]; then RUN_OPTIONS=" $RUN_OPTIONS --env http_proxy=$http_proxy "; fi
if [ -n "$https_proxy" ]; then RUN_OPTIONS=" $RUN_OPTIONS --env https_proxy=$https_proxy "; fi
if [ -n "$DNS_SERVER" ]; then RUN_OPTIONS=" $RUN_OPTIONS --dns=$DNS_SERVER "; fi

#docker run --rm --privileged=true --name=$containerName -ti \
#	$RUN_OPTIONS \
#	--env CC=$CC \
#	--env CXX=$CXX \
#	--env EXTRA_CFLAGS=$EXTRA_CFLAGS \
#	--env MAKE_DPKG=$MAKE_DPKG \
#	--env REMOTE_TESTS=$REMOTE_TESTS \
#	$imageName $command

