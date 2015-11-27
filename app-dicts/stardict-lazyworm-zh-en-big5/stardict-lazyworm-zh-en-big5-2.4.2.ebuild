# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

FROM_LANG="Traditional Chinese (BIG5)"
TO_LANG="English"
DICT_PREFIX="lazyworm-ce-"
DICT_SUFFIX="big5"

DESCRIPTION="懶蟲簡明漢英詞典"

inherit stardict
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
