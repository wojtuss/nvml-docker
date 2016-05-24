#!/bin/bash
set -e

repo=wojtuss
name=nvml-ubuntu1604:1
tag=${repo}/${name}

if [ -n $http_proxy ]; then BUILD_ARGS="--build-arg http_proxy=\$http_proxy"; fi
if [ -n $https_proxy ]; then BUILD_ARGS="$BUILD_ARGS --build-arg https_proxy=\$https_proxy"; fi

docker build -t $tag $BUILD_ARGS .

