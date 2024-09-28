#!/bin/bash
source scripts/utils.sh echo -n

# Saner programming env: these switches turn some bugs into errors
set -o errexit -o pipefail

# this script is meant to be used with 'datalad run'

# Download git-lfs
_VERSION=v2.13.3

mkdir -p bin/git-lfs-linux-amd64-${_VERSION}
rm -f bin/sha256sums
echo "03197488f7be54cfc7b693f0ed6c75ac155f5aaa835508c64d68ec8f308b04c1  git-lfs-linux-amd64-${_VERSION}.tar.gz" > bin/sha256sums

files_url=(
	"https://github.com/git-lfs/git-lfs/releases/download/${_VERSION}/git-lfs-linux-amd64-${_VERSION}.tar.gz bin/git-lfs-linux-amd64-${_VERSION}.tar.gz")

for file_url in "${files_url[@]}"
do
	echo "${file_url}"
done | add_urls

(cd bin/
 sha256sum -c sha256sums) || \
exit_on_error_code "Failed to download git-lfs"

# Install git-lfs
tar -C bin/git-lfs-linux-amd64-${_VERSION} -xf bin/git-lfs-linux-amd64-${_VERSION}.tar.gz || \
exit_on_error_code "Failed to extract git-lfs"

pushd bin/ >/dev/null
ln -sf git-lfs-linux-amd64-${_VERSION}/git-lfs .
popd >/dev/null
