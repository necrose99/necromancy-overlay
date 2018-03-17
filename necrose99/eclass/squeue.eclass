# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: squeue.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with squeue patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with squeue patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/squeue.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

case ${EAPI} in
	5)	: ;;
	*)	die "squeue.eclass: unsupported EAPI=${EAPI:-0}" ;;
esac

if [[ ${___ECLASS_ONCE_SQUEUE} != "recur -_+^+_- spank" ]]; then
___ECLASS_ONCE_SQUEUE="recur -_+^+_- spank"

inherit patch vars

EXPORT_FUNCTIONS src_unpack src_prepare pkg_postinst

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
squeue_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${SQUEUE_VER:=${SQUEUE_VER:-"${KMV}"}} # Patchset version
	: ${SQUEUE_SRC:=${SQUEUE_SRC:-"git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git"}} # Patchset sources url
	: ${SQUEUE_URL:=${SQUEUE_URL:-"http://git.kernel.org/cgit/linux/kernel/git/stable/stable-queue.git"}} # Patchset url
	: ${SQUEUE_INF:=${SQUEUE_INF:-"${YELLOW}Stable-queue patch-set version ${GREEN}${SQUEUE_VER}${YELLOW} from ${GREEN}${SQUEUE_URL}${NORMAL}"}}
	local skip_squeue_cfg=$(source $cfg_file 2>/dev/null; echo ${skip_squeue})
	: ${skip_squeue:=${skip_squeue_cfg:-no}} # skip_squeue=yes/no

	debug-print "${FUNCNAME}: SQUEUE_VER=${SQUEUE_VER}"
	debug-print "${FUNCNAME}: SQUEUE_SRC=${SQUEUE_SRC}"
	debug-print "${FUNCNAME}: SQUEUE_URL=${SQUEUE_URL}"
	debug-print "${FUNCNAME}: SQUEUE_INF=${SQUEUE_INF}"
	debug-print "${FUNCNAME}: skip_squeue=${skip_squeue}"
}

squeue_init_variables

HOMEPAGE="${HOMEPAGE} ${SQUEUE_URL}"

DEPEND="${DEPEND}
	dev-vcs/git"

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
squeue_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	local CSD="${GEEK_STORE_DIR}/squeue"
	local CWD="${T}/squeue"

	if [ -d "${CSD}" ]; then
		cd "${CSD}" || die "${RED}cd ${CSD} failed${NORMAL}"
		git pull > /dev/null 2>&1
	else
		git clone "${SQUEUE_SRC}" "${CSD}" > /dev/null 2>&1
	fi

	if [ -d "${CSD}/queue-${SQUEUE_VER}" ] ; then
		copy "${CSD}/queue-${SQUEUE_VER}" "${CWD}" > /dev/null 2>&1;
		mv ${CWD}/series ${CWD}/patch_list > /dev/null 2>&1;
	elif [ -d "${CSD}/releases/${PV}" ]; then
		copy "${CSD}/releases/${PV}" "${CWD}" > /dev/null 2>&1;
		mv ${CWD}/series ${CWD}/patch_list > /dev/null 2>&1;
	else
		ewarn "There is no stable-queue patch-set this time"
		skip_squeue="yes";
	fi
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
squeue_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"
	debug-print "$FUNCNAME: skip_squeue=$skip_squeue."

	if [ "${skip_squeue}" = "yes" ]; then
			echo
			ewarn "${RED}Skipping update to latest stable queue ...${NORMAL}"
		else
			ApplyPatch "${T}/squeue/patch_list" "${SQUEUE_INF}"
			move "${T}/squeue" "${WORKDIR}/linux-${KV_FULL}-patches/squeue"
	fi
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
squeue_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${SQUEUE_INF}"
}

fi
