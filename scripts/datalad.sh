#!/bin/bash

source scripts/utils.sh echo -n

git-annex version >/dev/null
exit_on_error_code "git-annex is missing"

datalad --version >/dev/null
exit_on_error_code "datalad is missing"

# Add bin to PATH
[[ -d "$(realpath bin/)" ]] && export PATH="${PATH}:$(realpath bin)"

datalad "$@"
