#!/bin/sh

set -x

: "${GITHUB_REPOSITORY?GITHUB_REPOSITORY has to be set. Did you use the actions/checkout action?}"

echo ${INPUT_MOLECULE_ARGS} > file2.txt
molecule_arg="$( cut -b 17- file2.txt)"

export MOLECULE_DISTRO=$molecule_arg

molecule ${INPUT_MOLECULE_OPTIONS} ${INPUT_MOLECULE_COMMAND} > file.txt && echo 'output<<EOF' >> $GITHUB_ENV && cat file.txt >> $GITHUB_ENV && echo 'EOF' >> $GITHUB_ENV
