# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} ) #pypy2_0 ie python 2.x compat to be tested. >=python-2.x <=python-3.x not yet supported.

inherit git-2 eutils  #git r3 blows python-single-r1
IUSE="+onbydefault +doc"
USE="doc" #Documentaion IS recomended. However Alow Users to kill if not wanted. 

EGIT_REPO_URI="https://github.com/USArmyResearchLab/Dshell.git"
EGIT_SOURCEDIR=${S}/

DESCRIPTION="Dshell is a network modular forensic analysis framework From USArmyResearchLab"
HOMEPAGE="https://github.com/USArmyResearchLab/Dshell"
SRC_URI=""
LICENSE="MIT"
SLOT="0"

DEPEND="dev-python/pygeoip
	dev-python/ipy
	dev-python/dpkt
	dev-python/pypcap
	dev-python/pycrypto"
RDEPEND="${DEPEND}
	doc? ( dev-python/epydoc )" 
	#doc? ( dev-python/epydoc[$(python_gen_usedep 'python2*')] )" ? error. for now....simplify

src_prepare() {
	cd ${S}/work/dshell-9999/
	rm -r ${S}/work/dshell-9999/.git && rm -r ${S}/work/dshell-9999/docker
	rm install-ubuntu.py && rm -r ${S}/work/dshell-9999/share
	dodir /usr/bin/dshell/
    cp -R "${S}/" "${D}/" || die "Copy failed"
	dodir /usr/share/doc/dshell

}

}
src_install() {
	mkdir "${ROOT}/opt/dshell"



#/usr/bin/{$p} emake Makefile all is extra janky....  .dshellrc dshell dshell-decode will set exports to
# {S} / build /var/tmp.. for the moment i'm not getting emake makefile all , upstream Makefile portage no like.
# and me nesting sed n x's =just as shity to patch the paths. in bash sh files. 
# until upstream make file is less flaky.. have to do this shit.
#Makefile cleanup segments. maily py scripts so if user updates best to clean house.
	rm -fv "${WORKDIR}/${PV}/dshell"
	rm -fv "${WORKDIR}/${PV}/dshell"
	rm -fv "${WORKDIR/${PV}/.dshellrc
	rm -fv "${WORKDIR}/${PV}/bin/decode 
	find ${WORKDIR}/${PV}/decoders -name '__init__.py' -exec rm -v {} \;
	find ${WORKDIR}/${PV}/decoders -name '*.pyc' -exec rm -v {} \;
	find ${WORKDIR}/${PV}/lib -name '*.pyc' -exec rm -v {} \;
	find ${WORKDIR}/${PV}/doc -name '*.htm*' -exec rm -v {} \;

#Makefile # Generating .dshellrc and dshell files #initpy: #pydoc:
	python $(PWD)/bin/generate-dshellrc.py $(PWD)
	dosbin $(PWD)/dshell
	dosbin $(PWD)/dshell-decode
	dosbin $(PWD)/bin/decode.py
	dosym $(PWD)/bin/decode.py $(PWD)/bin/decode
	find $(PWD)/decoders -type d -not -path \*.svn\* -print -exec touch {}/__init__.py \;
	(cd $(PWD)/doc && ./generate-doc.sh $(PWD) ) 
}
${WORKDIR}/${PV} ${ROOT}/opt/dshell/
do_syms() {
	
mkdir -p "${D}/usr/bin"
ln -s  
ln -s 
/usr/share/GeoIP /usr/bin/{$p}/share
cp -s /usr/bin/{$p}/doc/*.html /usr/share/doc/{$p}
dosym /usr/bin/{$p}LICENSE.txt /usr/share/doc/{$p}
dosym /usr/bin/{$p}README.md /usr/share/doc/{$p}
dosym "/opt/dshell/dshell" "${D}/usr/bin"
dosym "/opt/dshell/dshell-decode" "${D}/usr/bin" 
}
# havent forked emake into emake a+b then emake docs ondep yet as well, project newish so docs are in short supply. 
pkg_postinst() {
	rm /usr/bin/dshell/Makefile
	elog "Don't forget to run 'geoipupdate.sh -f' (or geoipupdate from"
	elog "net-misc/geoipupdate) or dev-python/pygeoip to populate ${ROOT}/opt/dshell/share/GeoIP/"
	elog "with geo-located IP address databases."
}
