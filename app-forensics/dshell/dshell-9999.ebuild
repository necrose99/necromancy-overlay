# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} ) #pypy2_0 ie python 2.x compat to be tested. >=python-2.x <=python-3.x not yet supported.

inherit git-2 eutils  #git r3 blows python-single-r1
IUSE="+onbydefault +doc"
USE="doc" #Documentaion IS recomended. However Alow Users to kill if not wanted. 

EGIT_REPO_URI="https://github.com/USArmyResearchLab/Dshell.git"
EGIT_SOURCEDIR=${S}

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
	dodir /usr/bin/{$p}
	dodir /usr/share/doc/{$p}
	cp "${D}" /usr/bin/{$p}

}

}
#src_install() {
#/usr/bin/{$p}
cd /usr/bin/{$p}
clean_rc:
	rm -fv $(PWD)/dshell
	rm -fv $(PWD)/dshell-decode
	rm -fv $(PWD)/.dshellrc
	rm -fv $(PWD)/bin/decode 

clean_py:
	find $(PWD)/decoders -name '__init__.py' -exec rm -v {} \;

clean_pyc:
	find $(PWD)/decoders -name '*.pyc' -exec rm -v {} \;
	find $(PWD)/lib -name '*.pyc' -exec rm -v {} \;

clean_pydoc:
	find $(PWD)/doc -name '*.htm*' -exec rm -v {} \;
c:
	# Generating .dshellrc and dshell files 
	python $(PWD)/bin/generate-dshellrc.py $(PWD)
	chmod 755 $(PWD)/dshell
	chmod 755 $(PWD)/dshell-decode
	chmod 755 $(PWD)/bin/decode.py
	ln -s $(PWD)/bin/decode.py $(PWD)/bin/decode

initpy:
	find $(PWD)/decoders -type d -not -path \*.svn\* -print -exec touch {}/__init__.py \;

pydoc:
	(cd $(PWD)/doc && ./generate-doc.sh $(PWD) ) 
}
}
do_syms
/usr/share/GeoIP /usr/bin/{$p}/share
cp -s /usr/bin/{$p}/doc/*.html /usr/share/doc/{$p}
dosym /usr/bin/{$p}LICENSE.txt /usr/share/doc/{$p}
dosym /usr/bin/{$p}README.md /usr/share/doc/{$p}
dosym /usr/bin/{$p}/dshell /usr/bin/
dosym /usr/bin/{$p}/dshell-decode /usr/bin/
# havent forked emake into emake a+b then emake docs ondep yet as well, project newish so docs are in short supply. 
pkg_postinst() {
	elog "Don't forget to run 'geoipupdate.sh -f' (or geoipupdate from"
	elog "net-misc/geoipupdate) to populate ${ROOT}/usr/share/GeoIP/"
	elog "with geo-located IP address databases."
}
