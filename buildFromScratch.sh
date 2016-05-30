#!/bin/bash
set -e

cp Dockerfile.template Dockerfile

repo=nvml
name=ubuntu:16.04
tag=${repo}/${name}

if [ -n "$http_proxy" ]
then
	BUILD_ARGS=" --build-arg http_proxy=$http_proxy "
	sed -i '/MAINTAINER .*/a ARG http_proxy' Dockerfile
fi
if [ -n "$https_proxy" ]
then
	BUILD_ARGS="$BUILD_ARGS --build-arg https_proxy=$https_proxy "
	sed -i '/MAINTAINER .*/a ARG https_proxy' Dockerfile
fi

docker build -t $tag $BUILD_ARGS .

