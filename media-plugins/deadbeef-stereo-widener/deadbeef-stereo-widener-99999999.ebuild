# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit deadbeef-plugins git-r3

DESCRIPTION="DeaDBeeF simple stereo widener plugin"
HOMEPAGE="https://gitorious.org/deadbeef-sm-plugins/stereo-widener"
EGIT_REPO_URI="https://gitorious.org/deadbeef-sm-plugins/stereo-widener.git"

LICENSE="MIT"
KEYWORDS=""

src_prepare() {
	epatch "${FILESDIR}/${PN}.patch"
}
