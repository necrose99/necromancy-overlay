# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1 git-r3

EGIT_REPO_URI="https://github.com/serpilliere/elfesteem.git"
	EGIT_BOOTSTRAP=""

DESCRIPTION="ElfEsteem ELF/PE editing library"
HOMEPAGE="http://hg.secdev.org/elfesteem/
https://github.com/serpilliere/elfesteem"
## updated and recently patched version.

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
