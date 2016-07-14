#!/bin/bash

# [[ $TRAVIS_REPO_SLUG == "wojtuss/nvml-docker" && $TRAVIS_BRANCH == "master" ]] || exit 0

commitRange=$([[ -n "$TRAVIS_COMMIT_RANGE" ]] && echo ${TRAVIS_COMMIT_RANGE/\.\.\./ } || echo $TRAVIS_COMMIT)
files=$(git diff-tree --no-commit-id --name-only -r $commitRange)
base_dir=testdir

for file in $files; do

	if [[ $file =~ ^($base_dir)\/Dockerfile\.($OS)-($OS_VER)$ ]] \
		|| [[ $file =~ ^($base_dir)\/.*\.sh$ ]]
	then
		cd testdir && ./build-image.sh $OS:$OS_VER
		[[ $TRAVIS_EVENT_TYPE == "pull_request" ]] || echo 1
		exit 0
	fi
done

