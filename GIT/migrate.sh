#!/bin/bash
# A script to migrate an existing git repository to a new one
# Written to save data from a local installation of gitlab to c4science.ch
# The method used here is described in
# https://help.github.com/articles/duplicating-a-repository/#mirroring-a-repository
# and will allow to save the whole history including tags and branches.
#
# Usage:
#  ./migrate.sh https://gitlab.epfl.ch/nborboen/Spring-3D.git git@c4science.ch:source/Spring-3D.git
#
# Note: all valid git URI should works, but in case you need authentification,
#       it's probably better to have your ssh keys set up (at least it's the
#       way it have been tested).
#
# Requirements: The destination repository should exists.
#
# Steps to follow to do it manually
#  1. Create a bare clone of the repository.
#     git clone --bare https://github.com/exampleuser/old-repository.git
#  2. Mirror-push to the new repository.
#     cd old-repository.git
#     git push --mirror https://github.com/exampleuser/new-repository.git
#  3. Remove the temporary local repository you created in step 1.
#     cd ..
#     rm -rf old-repository.git

#set -e -x
if [ ! $# -eq 2 ]; then
    echo "Usage: ./migrate.sh URI_OF_OLD_REPO URI_OF_NEW_REPO"
    exit 1
fi

: ${URI_OF_OLD_REPO:=$1}
: ${URI_OF_NEW_REPO:=$2}

echo Testing $URI_OF_OLD_REPO
OLD_REPO_TEST=$(git ls-remote $URI_OF_OLD_REPO)
if [ ! $? -eq 0 ]; then
    echo "The 'git ls-remote' command returns an error, please check the URI_OF_OLD_REPO (arg 1)"
    exit 1
fi
echo Testing $URI_OF_NEW_REPO
NEW_REPO_TEST=$(git ls-remote $URI_OF_NEW_REPO)
if [ ! $? -eq 0 ]; then
    echo "The 'git ls-remote' command returns an error, please check the URI_OF_NEW_REPO (arg 2)"
    exit 1
fi
# http://unix.stackexchange.com/questions/97920/how-to-cd-automatically-after-git-clone
git clone --bare $URI_OF_OLD_REPO && cd $(basename "$URI_OF_OLD_REPO")
git push --mirror $URI_OF_NEW_REPO
cd ..
rm -rf $(basename "$URI_OF_OLD_REPO")
