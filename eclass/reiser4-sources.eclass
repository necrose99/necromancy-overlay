# Copyright open-overlay 2015 by Alex
# Distributed under the terms of the GNU General Public License v2
# $Id$

# Description: This eclass provides functionality and default ebuild variables for building
# kernel with reiser4 patches easily.
# Original author: Alexander Kharlanov <a.xarlanov29@gmail.com>
# Maintainer: Alexander Kharlanov <a.xarlanov29@gmail.com>
#
# Please direct your bugs to the current eclass maintainer :)

inherit kernel-2


case ${EAPI:-0} in
  0) die "reiser4-sources.eclass doesn't support EAPI:-0" ;;
  *) ;;
esac

HOMEPAGE="https://reiser4.wiki.kernel.org"

EXPORT_FUNCTIONS pkg_postinst 

DEPEND="${RDEPEND} >=sys-fs/reiser4progs-1.1.0 app-arch/gzip"

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.

reiser4-sources_init_variables () {

debug-print-function ${FUNC} "$@"


: ${REISER4_PATCH_VER:=${REISER4_PATCH_VER:-"${PV}"}} # Patchset version

if [[ "${PV}" == "$3.19.5" ]]; then

: ${REISER4_PATCH_SRC:=${REISER4_PATCH_SRC-"mirror://sourceforge/project/reiser4/reiser4-for-linux-3.x/reiser4-for-${REISER4_PATCH_VER}.patch.gz"}} # Patchset sources url for kernel-3.x

else

: ${REISER4_PATCH_SRC:=${REISER4_PATCH_SRC-"mirror://sourceforge/project/reiser4/reiser4-for-linux-4.x/reiser4-for-${REISER4_PATCH_VER}.patch.gz"}} # Patchset sources url for kernel 4.x 

fi

: ${REISER4_PATCH_URL:=${REISER4_PATCH_URL:-"http://sourceforge.net/projects/reiser4"}} # Patchset url
: ${REISER4_PATCH_INFO:=${REISER4_PATCH_INFO:-"ReiserFS v4 version {REISER4_PATCH_VER} from ${REISER4_PATCH_URL}"}}

debug-print "${FUNC}: REISER4_PATCH_VER=${REISER4_PATCH_VER}"
	debug-print "${FUNC}: REISER4_PATCH_SRC=${REISER4_PATCH_SRC}"
	debug-print "${FUNC}: REISER4_PATCH_URL=${REISER4_PATCH_URL}"
	debug-print "${FUNC}: REISER4_PATCH_INFO=${REISER4_PATCH_INFO}"
}

reiser4-sources_init_variables

HOMEPAGE="${HOMEPAGE} ${REISER4_PATCH_URL}"
SRC_URI="${SRC_URI} ${REISER4_PATCH_SRC} ${KERNEL_URI}"

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
reiser4-sources_pkg_postinst() {
	debug-print-function ${FUNC} "$@"

                elog
		elog "Thanks open-overlay 2015 by Alex. Please report bugs gentoo ebuilds on this my email: a.xarlanov29@gmail.com Thanks."
		elog
}

