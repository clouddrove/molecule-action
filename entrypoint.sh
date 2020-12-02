#!/bin/sh

set -x

: "${GITHUB_REPOSITORY?GITHUB_REPOSITORY has to be set. Did you use the actions/checkout action?}"
ls -la 
pwd

molecule ${INPUT_MOLECULE_OPTIONS} ${INPUT_MOLECULE_COMMAND} ${INPUT_MOLECULE_ARGS} > file.txt && echo 'output<<EOF' >> $GITHUB_ENV && cat file.txt >> $GITHUB_ENV && echo 'EOF' >> $GITHUB_ENV
