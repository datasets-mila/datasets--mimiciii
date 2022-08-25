#!/bin/bash
set -o errexit -o pipefail -o noclobber

function acquire_lock {
	if [ -e .tmp/lock_stats ]
	then
		[[ "$$" -eq "`cat .tmp/lock_stats`" ]] || return 1
	else
		mkdir -p .tmp/
		echo -n "$$" > .tmp/lock_stats
		chmod -wx .tmp/lock_stats
		[[ "$$" -eq "`cat .tmp/lock_stats`" ]] || return 1
	fi
}

function delete_lock {
	rm -f .tmp/lock_stats
}

declare -a _dirs

_STDIN=0
while [[ $# -gt 0 ]]
do
	_arg="$1"; shift
	case "${_arg}" in
		--stdin) _STDIN=1
		echo "stdin = [${_STDIN}]"
		;;
		--) break ;;
		-h | --help)
		>&2 echo "Options for $(basename "$0") are:"
		>&2 echo "--stdin force read directories from stdin instead of script's arguments"
		exit 1
		;;
		*) _dirs+=("${_arg}") ;;
	esac
done

acquire_lock || exit 1

trap delete_lock EXIT

if [[ ${#_dirs[@]} == 0 ]] || [[ ${_STDIN} == 1 ]]
then
	readarray -t _dirs
fi

rm -f files_count.stats
for dir in "${_dirs[@]}"
do
	echo $(find $dir -type f | wc -l; echo $dir) >> files_count.stats
done

rm -f disk_usage.stats
for d in "${_dirs[@]}" ; do printf "%s\0" "${d}" ; done | du -Ls --files0-from - > disk_usage.stats

for d in "${_dirs[@]}"
do
	chmod -R a-w "$d"
done
