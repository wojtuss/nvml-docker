#!/bin/bash

#OS=ubuntu
#OS_VER=16.04

if [[ $TRAVIS_REPO_SLUG != "wojtuss/nvml-docker" || $TRAVIS_BRANCH != "master" ]]; then
	exit 0
fi

commitRange=$([[ -n "$TRAVIS_COMMIT_RANGE" ]] && echo ${TRAVIS_COMMIT_RANGE/\.\.\./ } || echo $TRAVIS_COMMIT)
echo commitRange: $commitRange

files=$(git diff-tree --no-commit-id --name-only -r $commitRange)
echo files: $files

#my="Dockerfile.ubuntu-16.04 Dockerfile.fedora-23"
#echo my: $my

base_dir=testdir

for file in $files; do
	echo file: $file

	if [[ $file =~ ^($base_dir)\/ ]]; then
		echo some important file
		if [[ $file =~ ^($base_dir)\/Dockerfile\. ]]; then
			echo some Dockerfile
			if [[ $file =~ ^($base_dir)\/Dockerfile\.$OS-$OS_VER ]]; then
				echo build $OS:$OS_VER
				if [[ ! $TRAVIS_PULL_REQUEST ]]; then
					echo push image to docker hub
				else
					echo skip pushing docker image
				fi
			fi
		else
			echo some other important files, build: $OS:$OS_VER
			break
		fi
	fi
done

