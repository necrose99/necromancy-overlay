# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $necrose99 exp veil wine setup metapackage, 
EAPI="5"

# inherit versionator

MY_P="${PN}-$(replace_version_separator 3 '-')"

DESCRIPTION="qt4-fsarchiver a program with a graphical interface for easy operation the archiving program fsarchiver (Flexible filesystem archiver) for backup and deployment tool"
HOMEPAGE="http://qt4-fsarchiver.sourceforge.net/"
SRC_URI=""
  LICENSE="metapackage"
SLOT="0"
    KEYWORDS="~amd64 ~x86"
    Ewarn "useflags uninstall will FILE shread veilwine reinstall is shred+install alias"
    IUSE="+onbydefault +install  -uninstall -reinstall"

  DEPEND="app-emulation/winetricks
         app-misc/srm"
    
          RDEPEND="${DEPEND}
          install? ( veil_wine_setup )
          uninstall? ( shread_veilwine )
          reinstall? ( reinstall_veilwine )
          ~x86? ( veil_wine_setup_x86 )
          ~amd64? ( veil_wine_setup_64 )"

S="${WORKDIR}/${PN}"
dir_prepair () {
  dodir /opt/veilwine
}
veil_wine_setup_x86 () {
	WINEPREFIX=~/opt/veilwine WINEARCH=win32 wine32 winecfg
	env WINEPREFIX=~/opt/veilwine wineboot -u
	export WINEPREFIX=
  }
  veil_wine_setup_64 () {
	env WINEPREFIX=~/opt/veilwine WINEARCH=win64 wine64 winecfg
	env WINEPREFIX=~/opt/veilwine wineboot -u
	export WINEPREFIX=/opt/veilwine
  }
  veilgroup_setup () { 
    groupadd veilusers
    usermod -aG root veilusers
  chgrp -hR  veilusers /opt/veilwine
  }
  
  # Basic 32-bit Python-in-Wine environment
winetricks allfonts
wget -N http://python.org/ftp/python/2.7.5/python-2.7.5.msi
wine msiexec /i python-2.7.5.msi /quiet

do_pip () {
# Pip
wget -N https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
wine ~/.wine/drive_c/Python27/python.exe ez_setup.py
wget -N https://raw.github.com/pypa/pip/master/contrib/get-pip.py
wine ~/.wine/drive_c/Python27/python.exe get-pip.py
}
# Dependency: Jinja2
wine ~/.wine/drive_c/Python27/Scripts/pip.exe install jinja2

# Dependency:  lxml requires Visual Studio, let's use a prebuilt binary instead
wget -N https://pypi.python.org/packages/2.7/l/lxml/lxml-3.2.3.win32-py2.7.exe
wine ~/.wine/drive_c/Python27/Scripts/easy_install.exe lxml-3.2.3.win32-py2.7.exe

# Dependency: Windows specific
wine ~/.wine/drive_c/Python27/Scripts/pip.exe install pyreadline

# Dependency: python-imaging
wine ~/.wine/drive_c/Python27/Scripts/pip.exe install pil

# Pyinstaller
wget -N http://sourceforge.net/projects/pywin32/files/pywin32/Build%20218/pywin32-218.win32-py2.7.exe/download?use_mirror=autoselect -O pywin32-218.win32-py2.7.exe
wine ~/.wine/drive_c/Python27/Scripts/easy_install.exe pywin32-218.win32-py2.7.exe
wine ~/.wine/drive_c/Python27/Scripts/pip.exe install pyinstaller
cp scripts/mailpile mailpile.py
wine ~/.wine/drive_c/Python27/Scripts/pyinstaller.exe --hidden-import=mailpile.jinjaextensions mailpile.py




reinstall_veilwine() {
  shread_veilwine 
  veil_wine_setup
}
shread_veilwine() {
Echo "Setting the world Onfire ***shreading your copy of wine for veil*******"
Echo "***shreading for your protection "
srm -r /opt/veilwine/*
}

pkg_postinst() {
	elog "you'll need to add youself to veilusers group to run the "build" of wine"
	ewarn "after you have ziped your payloads veil framwork , its wise to run the ebuild with reinstall to cleanup"
  elog "knock knock :ITs the cops ,got ya!! , rember veil can be dangerious to pc's and should be used for pentesting"
  ewarn "Dont get Caught , the police wont even let you have a solar calulator when thier though with you; should you be foolish abuse this."
}

