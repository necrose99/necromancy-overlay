# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"

DESCRIPTION="Virtual for nv/ati opencl SDK"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="app-admin/eselect-opencl
	|| (
		>=dev-util/ati-stream-sdk-bin-2.2
		>=dev-util/nvidia-cuda-sdk-3.0[opencl]
	)"
DEPEND=""
