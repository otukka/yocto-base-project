#!/bin/bash

set -e

git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
    while read path_key path
    do

        branch_key=$(echo $path_key | sed 's/\.path/.branch/')
        branch=$(git config -f .gitmodules --get "$branch_key")

        cd $path
        git checkout $branch
        cd ..

    done
