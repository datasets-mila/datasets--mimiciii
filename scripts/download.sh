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

git-annex addurl --fast -c annex.largefiles=anything --raw --batch --with-files <<EOF
$(for file_url in "${files_url[@]}" ; do echo "${file_url}" ; done)
EOF
git-annex get --fast -J8
git-annex migrate --fast -c annex.largefiles=anything *

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

for d in 3*/3*/ matched/p*/*/ 3*/RECORDS* 3*/3*/RECORDS* matched/RECORDS* matched/p*/p*/RECORDS* RECORDS*
do
	printf "%s\n" "${d}"
done | sort -u | ./scripts/stats.sh

git-annex add --fast -c annex.largefiles=nothing *.stats

[[ -f SHA256SUMS.txt ]] && sha256sum -c SHA256SUMS.txt
