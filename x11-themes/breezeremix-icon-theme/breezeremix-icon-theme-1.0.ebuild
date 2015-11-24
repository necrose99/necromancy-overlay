# Copyright open-overlay 2015 by Alex

EAPI=5
DESCRIPTION="Mix of Breeze and FaenzaFlattr icon themes."
HOMEPAGE="http://kde-look.org"
SRC_URI="https://github.com/manson9/${PN}/archive/master.tar.gz -> ${P}.tar.gz"

LICENSE="Creative Commons by"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
unpack "${A}"
mv "${PN}-master" "${P}"
}

src_install() {
insinto /usr/share/icons
doins -r BreezeRemix
dodoc README.md
}
