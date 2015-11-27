# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="sguil metapackage"
HOMEPAGE="http://sguil.sourceforge.net/"
SRC_URI=""
LICENSE="metapackage"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RDEPEND="
	=net-analyzer/sguil-client-"${PV}"
	=net-analyzer/sguil-sensor-"${PV}"
	=net-analyzer/sguil-server-"${PV}"
