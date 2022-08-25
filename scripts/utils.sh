#!/bin/bash

function exit_on_error_code {
	local _ERR=$?
	if [[ ${_ERR} -ne 0 ]]
	then
		>&2 echo "$(tput setaf 1)ERROR$(tput sgr0): $1: ${_ERR}"
		exit ${_ERR}
	fi
}

function test_enhanced_getopt {
	! getopt --test > /dev/null
	if [[ ${PIPESTATUS[0]} -ne 4 ]]
	then
		>&2 echo "enhanced getopt is not available in this environment"
		exit 1
	fi
}

function enhanced_getopt {
	local _NAME=$0
	while [[ $# -gt 0 ]]
	do
		local _arg="$1"; shift
		case "${_arg}" in
			--options) local _OPTIONS="$1"; shift ;;
			--longoptions) local _LONGOPTIONS="$1"; shift ;;
			--name) local _NAME="$1"; shift ;;
			--) break ;;
			-h | --help | *)
			if [[ "${_arg}" != "-h" ]] && [[ "${_arg}" != "--help" ]]
			then
				>&2 echo "Unknown option [${_arg}]"
			fi
			>&2 echo "Options for $(basename "$0") are:"
			>&2 echo "--options OPTIONS The short (one-character) options to be recognized"
			>&2 echo "--longoptions LONGOPTIONS The long (multi-character) options to be recognized"
			>&2 echo "--name NAME name that will be used by the getopt routines when it reports errors"
			exit 1
			;;
		esac
	done

	local _PARSED=`getopt --options="${_OPTIONS}" --longoptions="${_LONGOPTIONS}" --name="${_NAME}" -- "$@"`
	if [[ ${PIPESTATUS[0]} -ne 0 ]]
	then
		exit 2
	fi

	echo "${_PARSED}"
}

function init_conda_env {
	while [[ $# -gt 0 ]]
	do
		local _arg="$1"; shift
		case "${_arg}" in
			--name) local _name="$1"; shift
			echo "name = [${_name}]"
			;;
			--prefix) local _prefixroot="$1"; shift
			echo "prefix = [${_prefixroot}]"
			;;
			--tmp) local _prefixroot="$1"; shift
			>&2 echo "Deprecated --tmp option. Use --prefix instead."
			echo "tmp = [${_prefixroot}]"
			;;
			--) break ;;
			-h | --help | *)
			if [[ "${_arg}" != "-h" ]] && [[ "${_arg}" != "--help" ]]
			then
				>&2 echo "Unknown option [${_arg}]"
			fi
			>&2 echo "Options for ${FUNCNAME[0]} are:"
			>&2 echo "--name STR conda env prefix name"
			>&2 echo "--prefix DIR directory to hold the conda prefix"
			exit 1
			;;
		esac
	done

	local _CONDA_ENV=$CONDA_DEFAULT_ENV

	# Configure conda for bash shell
	eval "$(conda shell.bash hook)"
	if [[ ! -z ${_CONDA_ENV} ]]
	then
		# Stack previous conda env which gets cleared after
		# `eval "$(conda shell.bash hook)"`
		conda activate ${_CONDA_ENV}
		unset _CONDA_ENV
	fi

	if [[ ! -d "${_prefixroot}/env/${_name}/" ]]
	then
		conda create --prefix "${_prefixroot}/env/${_name}/" --yes --no-default-packages || \
		exit_on_error_code "Failed to create ${_name} conda env"
	fi

	conda activate "${_prefixroot}/env/${_name}/" && \
	exit_on_error_code "Failed to activate ${_name} conda env"

	"$@"
}

function init_venv {
	while [[ $# -gt 0 ]]
	do
		local _arg="$1"; shift
		case "${_arg}" in
			--name) local _name="$1"; shift
			echo "name = [${_name}]"
			;;
			--prefix) local _prefixroot="$1"; shift
			echo "prefix = [${_prefixroot}]"
			;;
			--tmp) local _prefixroot="$1"; shift
			>&2 echo "Deprecated --tmp option. Use --prefix instead."
			echo "tmp = [${_prefixroot}]"
			;;
			--) break ;;
			-h | --help | *)
			if [[ "${_arg}" != "-h" ]] && [[ "${_arg}" != "--help" ]]
			then
				>&2 echo "Unknown option [${_arg}]"
			fi
			>&2 echo "Options for ${FUNCNAME[0]} are:"
			>&2 echo "--name STR venv prefix name"
			>&2 echo "--prefix DIR directory to hold the virtualenv prefix"
			exit 1
			;;
		esac
	done

	if [[ ! -d "${_prefixroot}/venv/${_name}/" ]]
	then
		mkdir -p "${_prefixroot}/venv/${_name}/" && \
		virtualenv --no-download "${_prefixroot}/venv/${_name}/" || \
		exit_on_error_code "Failed to create ${_name} venv"
	fi

	source "${_prefixroot}/venv/${_name}/bin/activate" || \
	exit_on_error_code "Failed to activate ${_name} venv"
	python3 -m pip install --no-index --upgrade pip

	"$@"
}

function print_annex_checksum {
	local _CHECKSUM=MD5
	while [[ $# -gt 0 ]]
	do
		local _arg="$1"; shift
		case "${_arg}" in
			-c | --checksum) local _CHECKSUM="$1"; shift ;;
			-h | --help)
			>&2 echo "Options for $(basename "$0") are:"
			>&2 echo "[-c | --checksum CHECKSUM] checksum to print (default: MD5)"
			exit 1
			;;
			--) break ;;
			*) >&2 echo "Unknown option [${_arg}]"; exit 3 ;;
		esac
	done

	for _file in "$@"
	do
		local _annex_file=`ls -l -- "${_file}" | grep -o ".git/annex/objects/.*/${_CHECKSUM}.*"`
		if [[ ! -f "${_annex_file}" ]]
		then
			continue
		fi
		local _checksum=`echo "${_annex_file}" | xargs basename`
		local _checksum=${_checksum##*--}
		echo "${_checksum%%.*}  ${_file}"
	done
}

function list {
	while [[ $# -gt 0 ]]
	do
		local _arg="$1"; shift
		case "${_arg}" in
			-d | --dataset) local _DATASET="$1"; shift ;;
			-h | --help)
			>&2 echo "Options for $(basename "$0") are:"
			>&2 echo "[-d | --dataset PATH] dataset location"
			git-annex list --help >&2
			exit 1
			;;
			--) break ;;
			*) >&2 echo "Unknown option [${_arg}]"; exit 3 ;;
		esac
	done

	if [[ ! -z "${_DATASET}" ]]
	then
		pushd "${_DATASET}" >/dev/null || exit 1
	fi

	git-annex list "$@" | grep -o " .*" | grep -Eo "[^ ]+.*"

	if [[ ! -z "${_DATASET}" ]]
	then
		popd >/dev/null
	fi
}

function unshare_mount {
	if [[ ${EUID} -ne 0 ]]
	then
		unshare -rm ./"${BASH_SOURCE[0]}" unshare_mount "$@" <&0
		exit $?
	fi

	if [[ -z ${_SRC} ]]
	then
		local _SRC=${PWD}
	fi
	while [[ $# -gt 0 ]]
	do
		local _arg="$1"; shift
		case "${_arg}" in
			--src) local _SRC="$1"; shift
			echo "src = [${_SRC}]"
			;;
			--dir) local _DIR="$1"; shift
			echo "dir = [${_DIR}]"
			;;
			--cd) local _CD=1
			echo "cd = [${_CD}]"
			;;
	                --) break ;;
			-h | --help | *)
			if [[ "${_arg}" != "-h" ]] && [[ "${_arg}" != "--help" ]]
			then
				>&2 echo "Unknown option [${_arg}]"
			fi
			>&2 echo "Options for $(basename "$0") are:"
			>&2 echo "[--dir DIR] mount location"
			>&2 echo "[--src DIR] source dir (optional)"
			exit 1
			;;
		esac
	done

	mkdir -p ${_SRC}
	mkdir -p ${_DIR}

	local _SRC=$(cd "${_SRC}" && pwd -P)
	local _DIR=$(cd "${_DIR}" && pwd -P)

	mount -o bind ${_SRC} ${_DIR}
	exit_on_error_code "Could not mount directory"

	if [[ ! ${_CD} -eq 0 ]]
	then
		cd ${_DIR}
	fi

	unshare -U ${SHELL} -s "$@" <&0
}

# function unshare_mount {
# 	if [[ ${EUID} -ne 0 ]]
# 	then
# 		unshare -rm ./"${BASH_SOURCE[0]}" unshare_mount "$@" <&0
# 		exit $?
# 	fi
#
# 	if [[ -z ${_SRC} ]]
# 	then
# 		local _SRC=${PWD}
# 	fi
# 	if [[ -z ${_DIR} ]]
# 	then
# 		local _DIR=${_PWD}
# 	fi
# 	while [[ $# -gt 0 ]]
# 	do
# 		local _arg="$1"; shift
# 		case "${_arg}" in
# 			--src) local _SRC="$1"; shift
# 			echo "src = [${_SRC}]"
# 			;;
# 			--upper) local _UPPER="$1"; shift
# 			echo "upper = [${_UPPER}]"
# 			;;
# 			--dir) local _DIR="$1"; shift
# 			echo "dir = [${_DIR}]"
# 			;;
# 			--wd) local _WD="$1"; shift
# 			echo "wd = [${_WD}]"
# 			;;
# 			--cd) local _CD=1
# 			echo "cd = [${_CD}]"
# 			;;
# 	                --) break ;;
# 			-h | --help | *)
# 			if [[ "${_arg}" != "-h" ]] && [[ "${_arg}" != "--help" ]]
# 			then
# 				>&2 echo "Unknown option [${_arg}]"
# 			fi
# 			>&2 echo "Options for $(basename "$0") are:"
# 			>&2 echo "[--upper DIR] upper mount overlay"
# 			>&2 echo "[--wd DIR] overlay working directory"
# 			>&2 echo "[--src DIR] lower mount overlay (optional)"
# 			>&2 echo "[--dir DIR] mount location (optional)"
# 			exit 1
# 			;;
# 		esac
# 	done
#
# 	mkdir -p ${_SRC}
# 	mkdir -p ${_UPPER}
# 	mkdir -p ${_WD}
# 	mkdir -p ${_DIR}
#
# 	local _SRC=$(cd "${_SRC}" && pwd -P) || echo "${_SRC}"
# 	local _UPPER=$(cd "${_UPPER}" && pwd -P)
# 	local _WD=$(cd "${_WD}" && pwd -P)
# 	local _DIR=$(cd "${_DIR}" && pwd -P)
#
# 	mount -t overlay overlay -o lowerdir="${_SRC}",upperdir="${_UPPER}",workdir="${_WD}" "${_DIR}"
# 	exit_on_error_code "Could not mount overlay"
#
# 	if [[ ! ${_CD} -eq 0 ]]
# 	then
# 		cd ${_DIR}
# 	fi
#
# 	unshare -U ${SHELL} -s "$@" <&0
# }

if [[ ! -z "$@" ]]
then
	"$@"
fi
