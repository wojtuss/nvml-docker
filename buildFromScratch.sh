#!/bin/bash
set -e

repo=wojtuss
name=nvml-ubuntu1604:1
tag=${repo}/${name}

docker build -t $tag \
	--build-arg http_proxy=$http_proxy \
	--build-arg https_proxy=$http_proxy \
	.

