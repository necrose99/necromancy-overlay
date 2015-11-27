# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit java-pkg-2

DESCRIPTION="Desktop/Android/BlackBerry/iOS/HTML5 Java game development framework"
HOMEPAGE="https://libgdx.badlogicgames.com/"
SRC_URI="https://libgdx.badlogicgames.com/nightlies/dist/gdx-setup.jar"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( virtual/jre:1.7 virtual/jdk:1.7 )
	dev-util/android-sdk-update-manager"

S="${WORKDIR}"

RESTRICT="test"

src_unpack() { :; }
src_prepare() { :; }
src_compile() { :; }

src_install() {
	java-pkg_newjar "${DISTDIR}/${A}"
	java-pkg_dolauncher ${PN} --java_args "-Xmx512M"
}
