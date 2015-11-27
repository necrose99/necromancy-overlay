# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="0"
ETYPE="sources"
REISER4_PATCH_VER="${PV}"
inherit reiser4-sources
detect_version

DESCRIPTION="Full sources for the Linux kernel with reiser4 patch"
HOMEPAGE="${HOMEPAGE}"
SRC_URI="${SRC_URI}"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

UNIPATCH_LIST="${UNIPATCH_LIST} ../reiser4-for-${PV}.patch"

src_unpack() {
	unpack reiser4-for-${PV}.patch.gz
	kernel-2_src_unpack
}
