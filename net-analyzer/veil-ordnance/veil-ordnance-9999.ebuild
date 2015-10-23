# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev/udev-9999.ebuild,v 1.328 2015/06/10 02:37:44 floppym Exp $

EAPI=5

inherit inherit git-3

DESCRIPTION="Veil-Catapult is a payload delivery tool that integrates with Veil-Evasion"
GO_PN="github.com/hashicorp/${PN}"
HOMEPAGE="https://www.veil-framework.com/"
EGIT_REPO_URI=""https://github.com/Veil-Framework/Veil-Catapult.git
LICENSE="MPL-2.0"
SLOT="0"
IUSE="test"
