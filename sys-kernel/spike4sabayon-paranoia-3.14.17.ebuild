# Copyright 2004-2013 Sabayon Linux
# Distributed under the terms of the GNU General Public License v2


EAPI=5

inherit versionator

K_SABKERNEL_SELF_TARBALL_NAME="spike4sabayon-paranoia"
K_REQUIRED_LINUX_FIRMWARE_VER="20140828"
K_SABKERNEL_FORCE_SUBLEVEL="0"
K_SABKERNEL_PATCH_UPSTREAM_TARBALL="1"
K_KERNEL_NEW_VERSIONING="1"

inherit sabayon-kernel
#inherit wireless-compatible #injection
#https://github.com/Sabayon-Labs/spike-community-overlay/blob/master/necrose99/eclass/wireless-compatible.eclass
inherit grsec
#https://github.com/Sabayon-Labs/spike-community-overlay/blob/master/eclass/grsec.eclass


KEYWORDS="~amd64 ~x86"
DESCRIPTION="Official Sabayon Linux Standard kernel image"
RESTRICT="mirror"

DEPEND="${DEPEND}
	sys-apps/v86d"

IUSE="dmraid dracut -iscsi luks lvm mdadm plymouth splash injection  grsecurity"
