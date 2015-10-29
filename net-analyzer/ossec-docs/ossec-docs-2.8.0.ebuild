# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit webapp

DESCRIPTION="documentation and detection setups for OSSEC SIEM"
HOMEPAGE="http://www.ossec.net/"
SRC_URI="https://github.com/ossec/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd"

RDEPEND="virtual/httpd-php
	dev-lang/php[curl,mysql,gd]"

src_install() {
	webapp_src_preinst

	dodoc TODO.txt README*
	rm TODO.txt README* || die

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_src_install

	fperms 777 "${MY_HTDOCSDIR}"/generated-graphs
}

pkg_postinst() {
  elog "run: cp ${VHOST_ROOT}/${PN}/config.php.dist ${VHOST_ROOT}/${PN}/config.php"
  elog "Edit ${VHOST_ROOT}/${PN}/config.php and set database settings."
  webapp_pkg_postinst
}
