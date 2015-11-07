# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: bfq.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with bfq patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with bfq patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/bfq.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

case ${EAPI} in
	5)	: ;;
	*)	die "bfq.eclass: unsupported EAPI=${EAPI:-0}" ;;
esac

if [[ ${___ECLASS_ONCE_BFQ} != "recur -_+^+_- spank" ]]; then
___ECLASS_ONCE_BFQ="recur -_+^+_- spank"

inherit patch utils vars

EXPORT_FUNCTIONS src_unpack src_prepare pkg_postinst

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
bfq_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${BFQ_VER:=${BFQ_VER:-"${KMV}"}} # Patchset version
	: ${BFQ_SRC:=${BFQ_SRC:-"http://algo.ing.unimo.it/people/paolo/disk_sched/patches"}} # Patchset sources url
	: ${BFQ_URL:=${BFQ_URL:-"http://algo.ing.unimo.it/people/paolo/disk_sched/"}} # Patchset url
	: ${BFQ_INF:=${BFQ_INF:-"${YELLOW}Budget Fair Queueing Budget I/O Scheduler version ${GREEN}${BFQ_VER}${YELLOW} from ${GREEN}${BFQ_URL}${NORMAL}"}}

	debug-print "${FUNCNAME}: BFQ_VER=${BFQ_VER}"
	debug-print "${FUNCNAME}: BFQ_SRC=${BFQ_SRC}"
	debug-print "${FUNCNAME}: BFQ_URL=${BFQ_URL}"
	debug-print "${FUNCNAME}: BFQ_INF=${BFQ_INF}"
}

bfq_init_variables

HOMEPAGE="${HOMEPAGE} ${BFQ_URL}"

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
bfq_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	local CWD="${T}/bfq"
	shift
	test -d "${CWD}" >/dev/null 2>&1 && cd "${CWD}" || mkdir -p "${CWD}"; cd "${CWD}"

	get_from_url "${BFQ_SRC}" "${BFQ_VER}" > /dev/null 2>&1

	ls -1 "${CWD}" | grep ".patch" > "${CWD}"/patch_list
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
bfq_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${T}/bfq/patch_list" "${BFQ_INF}"
	move "${T}/bfq" "${WORKDIR}/linux-${KV_FULL}-patches/bfq"

	ApplyUserPatch "bfq"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
bfq_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${BFQ_INF}"
}

fi
