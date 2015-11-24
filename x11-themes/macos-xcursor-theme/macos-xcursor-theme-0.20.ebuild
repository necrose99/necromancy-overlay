# Copyright open-overlay 2015 by Alex

EAPI=5

DESCRIPTION="Official icon xcursor theme MacOSX."
HOMEPAGE="http://kde-look.org"
SRC_URI="https://github.com/manson9/${PN}/archive/master.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
unpack "${A}"
mv "${PN}-master" "${P}"
}

src_install() {
insinto /usr/share/cursors/xorg-x11
doins -r MacOSX
dodoc README.md
}
