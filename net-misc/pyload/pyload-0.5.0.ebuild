
# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils
inherit git-2

DESCRIPTION="Download manager for many One-Click-Hoster, container formats like DLC, video sites or just plain http/ftp links."
HOMEPAGE="http://www.pyload.org/"
EGIT_REPO_URI="git://github.com/pyload/pyload.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="crypt +curl +captcha javascript ssl webinterface"
RDEPEND=">=dev-lang/python-2.5[sqlite]
        crypt? ( dev-python/pycrypto )
        curl? ( dev-python/pycurl )
        captcha? ( app-text/tesseract
                   dev-python/imaging
                   javascript? ( dev-lang/spidermonkey ) )
        javascript? ( net-misc/pyload[captcha] )
        ssl? ( dev-python/pyopenssl )
        webinterface? ( dev-python/bottle )"

PYLOAD_DIR="/var/lib/${PN}"

pkg_setup() {
    enewgroup pyload
    # home directory is required .
    enewuser pyload -1 -1 "${PYLOAD_DIR}" pyload
}


#src_unpack() {
#        unpack ${A}
#}

src_install() {
        dodir "/usr/share"
        rm "${WORKDIR}/${P}/module/lib/bottle.py"
        rm -r "${WORKDIR}/${P}/.git"
        mv "${WORKDIR}/${P}" "${D}/usr/share/${PN}" || die "Install failed"
        fowners -R pyload:pyload go-rwx "/usr/share/${PN}"
        make_wrapper pyload /usr/share/${PN}/pyload.py
        make_wrapper pyload-cli /usr/share/${PN}/pyload-cli.py
#        if use qt4 ; then
#                make_wrapper pyloadGui /usr/share/${PN}/pyLoadGui.py
#                doicon icons/logo.png || die "doicon failed"
#                make_desktop_entry pyLoadGui PyLoad
#        fi
}
