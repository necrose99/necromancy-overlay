# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: zfs.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with zfs patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with zfs patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/zfs.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

case ${EAPI} in
	5)	: ;;
	*)	die "zfs.eclass: unsupported EAPI=${EAPI:-0}" ;;
esac

if [[ ${___ECLASS_ONCE_ZFS} != "recur -_+^+_- spank" ]]; then
___ECLASS_ONCE_ZFS="recur -_+^+_- spank"

inherit patch utils vars

EXPORT_FUNCTIONS src_unpack src_prepare pkg_postinst

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
zfs_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${ZFS_VER:=${ZFS_VER:-"master"}} # Patchset version
	: ${ZFS_SRC:=${ZFS_SRC:-"git://github.com/zfsonlinux/zfs.git"}} # Patchset sources url
	: ${ZFS_URL:=${ZFS_URL:-"http://zfsonlinux.org"}} # Patchset url
	: ${ZFS_INF:=${ZFS_INF:-"${YELLOW}Integrate Native ZFS on Linux version ${GREEN}${ZFS_VER}${YELLOW} from ${GREEN}${ZFS_URL}${NORMAL}"}}

	debug-print "${FUNCNAME}: ZFS_VER=${ZFS_VER}"
	debug-print "${FUNCNAME}: ZFS_SRC=${ZFS_SRC}"
	debug-print "${FUNCNAME}: ZFS_URL=${ZFS_URL}"
	debug-print "${FUNCNAME}: ZFS_INF=${ZFS_INF}"
}

zfs_init_variables

HOMEPAGE="${HOMEPAGE} ${ZFS_URL}"

LICENSE="${LICENSE} GPL-3"

DEPEND="${DEPEND}
	zfs?	(
		dev-vcs/git
		sys-fs/zfs[kernel-builtin(+)]
	)"

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
zfs_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	local CTD="${T}/zfs"
	local CSD="${GEEK_STORE_DIR}/zfs"
	local CWD="${T}/zfs"
	shift

	if [ -d ${CSD} ]; then
	cd "${CSD}" || die "${RED}cd ${CSD} failed${NORMAL}"
		if [ -e ".git" ]; then # git
			git fetch --all && git pull --all
		fi
	else
		git clone "${ZFS_SRC}" "${CSD}" > /dev/null 2>&1; cd "${CSD}" || die "${RED}cd ${CSD} failed${NORMAL}"; git_get_all_branches
	fi

	copy "${CSD}" "${CWD}"
	cd "${CWD}" || die "${RED}cd ${CWD} failed${NORMAL}"

	git_checkout "${ZFS_VER}" > /dev/null 2>&1 git pull > /dev/null 2>&1

	rm -rf "${CWD}"/.git || die "${RED}rm -rf ${CWD}/.git failed${NORMAL}"
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
zfs_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	local CWD="${T}/zfs"
	shift

	einfo "${ZFS_INF}"
	cd "${CWD}" || die "${RED}cd ${CWD} failed${NORMAL}"
	[ -e autogen.sh ] && ./autogen.sh > /dev/null 2>&1
	./configure \
		--prefix=${PREFIX}/ \
		--libdir=${PREFIX}/lib \
		--includedir=/usr/include \
		--datarootdir=/usr/share \
		--enable-linux-builtin=yes \
		--with-blkid \
		--with-linux=${S} \
		--with-linux-obj=${S} \
		--with-spl="${T}/spl" \
		--with-spl-obj="${T}/spl" > /dev/null 2>&1 || die "${RED}zfs ./configure failed${NORMAL}"
	./copy-builtin ${S} > /dev/null 2>&1 || die "${RED}zfs ./copy-builtin ${S} failed${NORMAL}"

	cd "${S}" || die "${RED}cd ${S} failed${NORMAL}"
	make mrproper > /dev/null 2>&1

	rm -rf "${T}/{spl,zfs}" || die "${RED}rm -rf ${T}/{spl,zfs} failed${NORMAL}"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
zfs_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${ZFS_INF}"
}

fi
