# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit deadbeef-plugins

GITHUB_COMMIT="ff827d577941481b1e6e360f87a254f50c524628"

DESCRIPTION="DeaDBeeF bookmark manager plugin"
HOMEPAGE="https://github.com/cboxdoerfer/ddb_bookmark_manager"
SRC_URI="https://github.com/cboxdoerfer/ddb_bookmark_manager/archive/${GITHUB_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~*"

S="${WORKDIR}/ddb_bookmark_manager-${GITHUB_COMMIT}"
