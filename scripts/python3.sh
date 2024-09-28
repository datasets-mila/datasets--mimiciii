#!/bin/bash

source scripts/utils.sh echo -n

_python3_version=$(git config --file scripts/config/python3_config --get python3.version || echo -n)
init_venv --name cp${_python3_version}/py --prefix .tmp/ -- python3 "$@"
