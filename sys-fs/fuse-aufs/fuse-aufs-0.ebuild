# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fuseiso/fuseiso-20070708-r1.ebuild,v 1.3 2014/01/14 13:58:42 ago Exp $
# https://github.com/Sabayon-Labs/spike-community-overlay some alpha/beta ebuilds live hear 
# layman -f -a https://raw.githubusercontent.com/Sabayon-Labs/spike-community-overlay/master/overlays.xml
# Spike-pentesting.org a Gentoo & Sabayon Based Pentest Distribution. 
# necrose99 Michael R. Lawence
## Wishlist:no eligant means to if sabayon-kernel or virtual-(IE gentoo) 
#or our preffered spike kerenl (sabayon/gentoo var) slighly hardened & Pentesty var of sabayon defacto kernel
## Else gentoo's or etc. 
#pitty thier isnt an eassier automagical kernel probe/kernel-SRC's probe and make We all have diff kernel flavor tastes.
# but perl/APP:Witchcraft CI-tinderbox will chew & make bin-packages in ourcase
# USE="+recursion"  for /usr/src/$LINUX-{$wildcard}-{$wildversion} 
#nvidia patch day urhgrr wish for that too +recursion"
# find and try and build the fuse for them if aufs3 modules aint built when posible... .

EAPI=5
inherit eutils versionator

DESCRIPTION="virtual to build sys-fs/aufs3 as a FUSE module for simplicity & Ease."

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-debug doc +fuse hfs inotify kernel-patch +nfs pax_kernel +ramfs"

RDEPEND="sys-fs/aufs3 
  	sys-fs/fuse
	>=sys-kernel/spike-sources-0
	>=sys-kernel/linux-spike-0
	>=sabayon-sources-0
  	>=sys-kernel/linux-sabayon-0
	>=virtual/linux-kernel-0
	>=virtual/linux-sources-0"
DEPEND="${RDEPEND}
