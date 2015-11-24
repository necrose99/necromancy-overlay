# Copyright open-overlay 2015 by Alex

EAPI=5

DESCRIPTION="Official icon theme vibrancy."
HOMEPAGE="http://gnome-look.org"

SRC_URI="https://github.com/manson9/${PN}/archive/master.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3.0+"
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
	doins -r Vibrancy-Colors Vibrancy-Colors-Dark Vibrancy-Colors-Full-Dark Vibrancy-Colors-Light Vibrancy-Colors-NonMono-Dark Vibrancy-Colors-NonMono-Light Vibrancy-Dark-Aqua Vibrancy-Dark-Blue Vibrancy-Dark-Blue-Vivid Vibrancy-Dark-Brown Vibrancy-Dark-Graphite Vibrancy-Dark-Green Vibrancy-Dark-Orange Vibrancy-Dark-Pink Vibrancy-Dark-Purple Vibrancy-Dark-Red Vibrancy-Dark-Teal Vibrancy-Dark-Yellow Vibrancy-Full-Dark-Aqua Vibrancy-Full-Dark-Blue Vibrancy-Full-Dark-Blue-Vivid Vibrancy-Full-Dark-Blue-Vivid Vibrancy-Full-Dark-Brown Vibrancy-Full-Dark-Graphite Vibrancy-Full-Dark-Green Vibrancy-Full-Dark-Orange Vibrancy-Full-Dark-Pink Vibrancy-Full-Dark-Purple Vibrancy-Full-Dark-Red Vibrancy-Full-Dark-Teal Vibrancy-Full-Dark-Yellow Vibrancy-Light-Aqua Vibrancy-Light-Blue Vibrancy-Light-Blue-Vivid Vibrancy-Light-Brown Vibrancy-Light-Graphite Vibrancy-Light-Green Vibrancy-Light-Orange Vibrancy-Light-Pink Vibrancy-Light-Purple Vibrancy-Light-Red Vibrancy-Light-Teal Vibrancy-Light-Yellow Vibrancy-NonMono-Dark-Aqua Vibrancy-NonMono-Dark-Blue Vibrancy-NonMono-Dark-Blue-Vivid Vibrancy-NonMono-Dark-Brown Vibrancy-NonMono-Dark-Graphite Vibrancy-NonMono-Dark-Green Vibrancy-NonMono-Dark-Orange Vibrancy-NonMono-Dark-Pink Vibrancy-NonMono-Dark-Purple Vibrancy-NonMono-Dark-Red Vibrancy-NonMono-Dark-Teal Vibrancy-NonMono-Dark-Yellow Vibrancy-NonMono-Light-Aqua Vibrancy-NonMono-Light-Blue Vibrancy-NonMono-Light-Blue-Vivid Vibrancy-NonMono-Light-Brown Vibrancy-NonMono-Light-Graphite Vibrancy-NonMono-Light-Green Vibrancy-NonMono-Light-Orange Vibrancy-NonMono-Light-Pink Vibrancy-NonMono-Light-Purple Vibrancy-NonMono-Light-Red Vibrancy-NonMono-Light-Teal Vibrancy-NonMono-Light-Yellow  
	dodoc README.md
}
