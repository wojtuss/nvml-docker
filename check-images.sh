#!/bin/bash

[[ $TRAVIS_REPO_SLUG == "wojtuss/nvml-docker" && $TRAVIS_BRANCH == "master" ]] || exit 0

commitRange=$([[ -n "$TRAVIS_COMMIT_RANGE" ]] && echo ${TRAVIS_COMMIT_RANGE/\.\.\./ } || echo $TRAVIS_COMMIT)

files=$(git diff-tree --no-commit-id --name-only -r $commitRange)
echo files: $files

base_dir=testdir

for file in $files; do
	echo file: $file

	if [[ $file =~ "^($base_dir)\/Dockerfile\.$OS-$OS_VER" \
		|| ( $file =~ "^($base_dir)\/" && ! $file =~ "^($base_dir)\/Dockerfile\." ) ]]; then
		echo build $OS:$OS_VER
		if [[ ! $TRAVIS_PULL_REQUEST ]]; then
			echo push image to docker hub
		else
			echo skip pushing docker image
		fi
		exit 0
	fi
done

