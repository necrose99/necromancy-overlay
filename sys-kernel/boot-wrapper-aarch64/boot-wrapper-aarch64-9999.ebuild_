# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#https://silver.arm.com/download/Development_Tools/ESL:_Fast_Models/Fast_Models/FM000-KT-00035-r9p5-41rel0/FM000-KT-00035-r9p5-41rel0.tgz

inherit kernel-2 git-2
detect_version
#DEPEND="sys-kernel/boot-wrapper-aarch64"

DESCRIPTION="Live -git  arm64 linaro version of the Linux kernel"
HOMEPAGE="https://github.com/torvalds/linux"
EGIT_REPO_URI="https://github.com/artagnon/boot-wrapper-aarch64.git"
DEPEND="sys-devel/gcc-linaro" 
KEYWORDS="~arm64"
IUSE=""

pkg_postinst() {
	postinst_sources
}
