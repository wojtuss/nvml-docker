#!/bin/bash

#OS=ubuntu
#OS_VER=16.04

commitRange=$([[ -n "$TRAVIS_COMMIT_RANGE" ]] && echo ${TRAVIS_COMMIT_RANGE/\.\.\./ } || echo $TRAVIS_COMMIT)
echo commitRange: $commitRange

files=$(git diff-tree --no-commit-id --name-only -r $commitRange)
echo files: $files

#my="Dockerfile.ubuntu-16.04 Dockerfile.fedora-23"
#echo my: $my

for file in $files; do
	echo file: $file
	if [[ $file =~ ^testdir\/Dockerfile\. ]]; then
		if [[ $file =~ ^testdir\/Dockerfile\.$OS-$OS_VER ]]; then
			echo Dockerfile, build: $OS:$OS_VER
		fi
	else
		echo other, build: $OS:$OS_VER
		break
	fi
done

