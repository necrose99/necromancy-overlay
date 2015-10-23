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

RDEPEND="dev-python/jsonrpc
>=net-analyzerVeil-Evasion-2.21.1.1
net-analyzerVeil-Ordnance 
net-analyzerVeil-Pillage
net-analyzerVeil-Catapult"

pkg_postinst() {
	readme.gentoo_pkg_postinst
}
