# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: necrose99 exp $ 

EAPI=5

PYTHON_COMPAT="python2_7"
inherit eutils python-single-r1 multilib

DESCRIPTION="The Backdoor Factory Proxy (BDFProxy)can be used to Patch binaries during download ala MITM.s for pentesting"
HOMEPAGE="https://github.com/secretsquirrel/BDFProxy"
SRC_URI="https://github.com/secretsquirrel/BDFProxy/archive/0.3.6.tar.gz -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="net-proxy/mitmproxy
dev-python python-magic
dev-util/capstone/"
DEPEND="${RDEPEND}"
# remove mallory crap to do. 

S="${WORKDIR}/IntrepidusGroup-mallory-4c3ea86c5679"

src_prepare(){
	epatch "${FILESDIR}/mallory-pillow.patch"
	#add shebang
	sed -e '1s|^|#!/usr/bin/env python\n\n|' -i src/mallory.py src/launchgui.py

	#TODO: change .log file location, sed src/config.py
}

src_install(){
	dodir /usr/$(get_libdir)/${PN}

	cp -R src/* "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"

	#The python line is in wrong place. We patch it manually
#	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}/${PN}.py

	fperms +x /usr/$(get_libdir)/${PN}/${PN}.py
	fperms +x /usr/$(get_libdir)/${PN}/launchgui.py

	#TODO
	#dodesktop sudo -E python2.7 ./launchgui.py
	dobin "${FILESDIR}"/{malloryd,mallory_gui}

	dodoc README SETUP CONTRIB
}

### ADD Ebuild skell I'm none to fond of arch pkgbuild files but they on ocassion have usefullness

# Maintainer: ArchAssault <team archassault org>
pkgname=bdfproxy-git
pkgver=20150420.r62
pkgrel=1
groups=('archassault' 'archassault-proxy')
pkgdesc="Patch Binaries via MITM: BackdoorFactory + mitmProxy."
url="https://github.com/secretsquirrel/BDFProxy"
arch=('any')
license=('GPL3')
depends=('capstone' 'python2-pefile' 'mitmproxy')
makedepends=('git')
source=("${pkgname}::git+https://github.com/secretsquirrel/BDFProxy.git")
sha512sums=('SKIP')

pkgver() {
    cd "${pkgname}"
    printf "%s.r%s" "$(git show -s --format=%ci master | sed 's/\ .*//g;s/-//g')" "$(git rev-list --count HEAD)"
}

prepare(){
  cd "${pkgname}"
  git submodule init
  git submodule update
}

package() {
  cd "${pkgname}"
  install -dm755 "$pkgdir/usr/share/bdfproxy"
  install -dm755 "$pkgdir/usr/bin/"
  cp -ar --no-preserve=ownership * "$pkgdir/usr/share/bdfproxy"
  cat > "$pkgdir/usr/bin/bdfproxy" <<EOF
#!/bin/sh
python2 /usr/share/bdfproxy/bdf_proxy.py "\$@"
EOF
  chmod +x "$pkgdir/usr/bin/bdfproxy"
  find "${pkgdir}" -type f -name '*.py' | xargs sed -i 's|#!/usr/bin/env python|#!/usr/bin/env python2|'
}
