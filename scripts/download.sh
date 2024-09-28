#!/bin/bash

source scripts/utils.sh echo -n

# Saner programming env: these switches turn some bugs into errors
set -o errexit -o pipefail

# This script is meant to be used with the command 'datalad run'

_SNAME=$(basename "$0")
mkdir -p logs/

files_url=(
        "https://physionet.org/files/mimic3wdb/1.0/LICENSE.txt LICENSE.txt"
        "https://physionet.org/files/mimic3wdb/1.0/SHA256SUMS.txt SHA256SUMS.txt")

for file_url in "${files_url[@]}"
do
	echo "${file_url}"
done | add_urls

# Link wget download dir to dataset dir
mkdir -p wget_dir/physionet.org/files/mimic3wdb/
pushd wget_dir/physionet.org/files/mimic3wdb/ >/dev/null
ln -sfT "$(realpath --relative-to=. "$(dirs +1)")/" 1.0
popd >/dev/null

# Create download tree
chmod -R +w wget_dir/
wget -r -l1 -N -c -np https://physionet.org/files/mimic3wdb/1.0/ -P wget_dir/ -o /dev/null
wget -r -l1 -N -c -np https://physionet.org/files/mimic3wdb/1.0/matched/ -P wget_dir/ -o /dev/null

# Download dataset
ls -d 3*/ matched/p*/ | \
	_MAIN_PROC=$$ _SNAME=${_SNAME} xargs -n1 -P8 sh -a -c 'wget -r -N -c -np https://physionet.org/files/mimic3wdb/1.0/$0 -P wget_dir/ -o /dev/stderr \
	1>logs/${_SNAME}_${_MAIN_PROC}.out_$$ 2>logs/${_SNAME}_${_MAIN_PROC}.err_$$'

for d in 3*/ matched/ RECORDS* index.html
do
	printf "%s\n" "${d}"
done | add_files --no-annex

git-annex add --fast -c annex.largefiles=nothing *.stats

# Verify dataset
[[ ! -f SHA256SUMS.txt ]] || sha256sum -c SHA256SUMS.txt

if [[ -f md5sums ]]
then
	md5sum -c md5sums
fi
list -- --fast | while read f
do
	if [[ -z "$(echo "${f}" | grep -E "^bin/")" ]] &&
		[[ -z "$(grep -E " (\./)?${f//\./\\.}$" md5sums)" ]]
	then
		md5sum "${f}" >> md5sums
	fi
done
