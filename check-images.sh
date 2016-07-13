#!/bin/bash

#OS=ubuntu
#OS_VER=16.04

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
		if [[ $file =~ ^($base_dir)\/Dockerfile\.$OS-$OS_VER ]]; then
			echo Dockerfile, build: $OS:$OS_VER
			if [[ ! $TRAVIS_PULL_REQUEST ]]; then
				echo push image to docker hub
			else
				echo skip pushing docker image
			fi
		else
			echo other, build: $OS:$OS_VER
			break
		fi
	fi
done

