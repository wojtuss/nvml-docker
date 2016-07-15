#!/bin/bash

gitrepo=wojtuss/nvml-docker
gitbranch=master
# [[ $TRAVIS_REPO_SLUG == $gitrepo && $TRAVIS_BRANCH == $gitbranch ]] \
#	|| echo "Nothing to check (the commit is not for $gitbranch branch of $gitrepo." && exit 0

commitRange=$([[ -n "$TRAVIS_COMMIT_RANGE" ]] && echo ${TRAVIS_COMMIT_RANGE/\.\.\./ } || echo $TRAVIS_COMMIT)
echo "Commit range: $commitRange"

files=$(git diff-tree --no-commit-id --name-only -r $commitRange)
echo "Files modified within the commit range:"
for file in $files; do echo $file; done

base_dir=testdir

for file in $files; do
	if [[ $file =~ ^($base_dir)\/Dockerfile\.($OS)-($OS_VER)$ ]] \
		|| [[ $file =~ ^($base_dir)\/.*\.sh$ ]]
	then
		echo "Rebuilding Docker image for Dockerfile\.($OS)-($OS_VER)"
		pushd testdir
		./build-image.sh $OS:$OS_VER
		popd
		[[ $TRAVIS_EVENT_TYPE == "pull_request" ]] || touch push_new_Docker_image_to_repo
		exit 0
	fi
done

echo "The Docker image does not need rebuilding."
