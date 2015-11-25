# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit git-2

DESCRIPTION="Firmware for open source host brcmsmac and brcmfmac drivers"
HOMEPAGE="http://linuxwireless.org/en/users/Drivers/brcm80211"
EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE=""
RDEPEND="|| ( virtual/udev sys-apps/hotplug )"

src_unpack() {
   git-2_src_unpack
}

src_install() {
   insinto /lib/firmware/brcm
# brcmsmac driver
   doins brcm/bcm43xx_hdr-0.fw brcm/bcm43xx-0.fw
# brcmfmac driver
#   doins brcm/bcm4329-fullmac-4.bin brcm/brcm/brcmfmac4329.bin
} 
