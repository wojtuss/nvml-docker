#!/bin/bash

[[ $TRAVIS_REPO_SLUG == "wojtuss/nvml-docker" && $TRAVIS_BRANCH == "master" ]] || exit 0

commitRange=$([[ -n "$TRAVIS_COMMIT_RANGE" ]] && echo ${TRAVIS_COMMIT_RANGE/\.+/ } || echo $TRAVIS_COMMIT)

files=$(git diff-tree --no-commit-id --name-only -r $commitRange)
echo files: $files

base_dir=testdir

for file in $files; do
	echo file: $file

	if [[ $file =~ ^($base_dir)\/Dockerfile\.($OS)-($OS_VER)$ ]] \
		|| [[ $file =~ ^($base_dir)\/.*\.sh$ ]]
	then
		echo build $OS:$OS_VER
		cd testdir && ./build-image.sh $OS:$OS_VER

		if [[ $TRAVIS_EVENT_TYPE == "pull_request" ]]; then
			echo skip pushing docker image
		else
			sudo docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
			echo push image to docker hub
			sudo docker push wojtuss/$OS:$OS_VER
		fi
		exit 0
	fi
done

