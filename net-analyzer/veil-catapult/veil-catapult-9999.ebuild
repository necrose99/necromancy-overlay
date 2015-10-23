# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev/udev-9999.ebuild,v 1.328 2015/06/10 02:37:44 floppym Exp $

EAPI=5

inherit autotools bash-completion-r1 eutils linux-info multilib multilib-minimal toolchain-funcs udev user versionator

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="git://anongit.freedesktop.org/systemd/systemd"
	inherit git-2
	patchset=
else
	patchset=
	SRC_URI="http://www.freedesktop.org/software/systemd/systemd-${PV}.tar.xz"
	if [[ -n "${patchset}" ]]; then
				SRC_URI="${SRC_URI}
					http://dev.gentoo.org/~ssuominen/${P}-patches-${patchset}.tar.xz
					http://dev.gentoo.org/~williamh/dist/${P}-patches-${patchset}.tar.xz"
			fi
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
fi
