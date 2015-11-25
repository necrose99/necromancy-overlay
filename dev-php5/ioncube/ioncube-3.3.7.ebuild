# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/xcache/xcache-1.3.0.ebuild,v 1.1 2009/08/30 06:45:20 hollow Exp $

PHP_EXT_NAME="ioncube"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="yes"
PHPSAPILIST="apache2"

inherit php-ext-base-r1 versionator

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Loader for ionCube encoded files"
HOMEPAGE="http://www.ioncube.com/loaders.php"
SRC_URI_AMD64="amd64? ( http://dev.gentoo.org/~hollow/distfiles/ioncube_loaders_lin_x86-64-${PV}.tar.bz2 )"
SRC_URI_X86="x86? ( http://dev.gentoo.org/~hollow/distfiles/ioncube_loaders_lin_x86-${PV}.tar.bz2 )"
SRC_URI="${SRC_URI_AMD64} ${SRC_URI_X86}"
LICENSE="IONCUBE_LOADERS"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

need_php_by_category

S="${WORKDIR}/${PN}"

src_compile() {
	:
}

src_install() {
	# php thread safe?
	local ts=""
	has_zts
	[[ $? -eq 0 ]] && ts="_ts"

	# php major.minor version number
	local v=$(best_version dev-lang/php|sed 's|^dev-lang/php-||')
	v=$(get_version_component_range 1-2 $v)

	if [[ ! -e "${S}/ioncube_loader_lin_${v}${ts}.so" ]]; then
		die "No ${P} build for your PHP version (${v}) available."
	fi

	insinto "${EXT_DIR}"
	newins "${S}/ioncube_loader_lin_${v}${ts}.so" "${PHP_EXT_NAME}.so" || die "Unable to install extension"

	# stolen from php-ext-base-r1.eclass. we need to make a custom symlink so
	# ioncube gets loaded first. otherwise xcache, zendoptimizer etc won't work
	php-ext-base-r1_buildinilist
	php-ext-base-r1_addextension "${PHP_EXT_NAME}.so"
	for inifile in ${PHPINIFILELIST}; do
		inidir="${inifile/${PHP_EXT_NAME}.ini/}"
		inidir="${inidir/ext/ext-active}"
		dodir "/${inidir}"
		dosym "/${inifile}" "/${inidir}/00_${PHP_EXT_NAME}.ini"
	done
}
