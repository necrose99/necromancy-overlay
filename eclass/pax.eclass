# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: pax.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with pax patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with pax patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/pax.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

case ${EAPI} in
	5)	: ;;
	*)	die "pax.eclass: unsupported EAPI=${EAPI:-0}" ;;
esac

if [[ ${___ECLASS_ONCE_PAX} != "recur -_+^+_- spank" ]]; then
___ECLASS_ONCE_PAX="recur -_+^+_- spank"

inherit patch utils vars

EXPORT_FUNCTIONS src_prepare pkg_postinst

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
pax_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${PAX_VER:=${PAX_VER:-"${KMV}"}} # Patchset version
	: ${PAX_SRC:=${PAX_SRC:-"http://grsecurity.net/test/pax-linux-${PAX_VER/KMV/$KMV}.patch"}} # Patchset sources url
	: ${PAX_URL:=${PAX_URL:-"http://pax.grsecurity.net"}} # Patchset url
	: ${PAX_INF:=${PAX_INF:-"${YELLOW}PAX patches version ${GREEN}${PAX_VER}${YELLOW} from ${GREEN}${PAX_URL}${NORMAL}"}}

	debug-print "${FUNCNAME}: PAX_VER=${PAX_VER}"
	debug-print "${FUNCNAME}: PAX_SRC=${PAX_SRC}"
	debug-print "${FUNCNAME}: PAX_URL=${PAX_URL}"
	debug-print "${FUNCNAME}: PAX_INF=${PAX_INF}"
}

pax_init_variables

HOMEPAGE="${HOMEPAGE} ${PAX_URL}"

SRC_URI="${SRC_URI}
	pax?	( ${PAX_SRC} )"

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
pax_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/pax-linux-${PAX_VER/KMV/$KMV}.patch" "${PAX_INF}"

	ApplyUserPatch "pax"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
pax_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${PAX_INF}"
}

fi
