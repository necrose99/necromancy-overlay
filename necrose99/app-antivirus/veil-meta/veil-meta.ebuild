# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit readme.gentoo

DESCRIPTION="Meta ebuild for Veil-Framework"
HOMEPAGE="https://www.veil-framework.com 
https://github.com/Veil-Framework"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+icons lightdm lximage -minimal +policykit powermanagement sddm ssh-askpass"

S="${WORKDIR}"

DOC_CONTENTS="
	For your convenience you can review
	https://www.veil-framework.com/guidesvideos/

RDEPEND="app-antivirus/Veil-Evasion
	app-antivirus/Veil-Ordnance 
	app-antivirus/Veil-Pillage
	app-antivirus/Veil-Catapult"

pkg_postinst() {
	readme.gentoo_pkg_postinst # work in progress.
}
