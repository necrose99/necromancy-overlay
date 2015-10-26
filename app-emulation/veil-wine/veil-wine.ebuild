# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $necrose99 exp veil wine setup metapackage, 
EAPI="5"

# inherit versionator

MY_P="${PN}-$(replace_version_separator 3 '-')"

DESCRIPTION="user meta wine setup to support veil-framwork/metasploit"
HOMEPAGE=""
SRC_URI="
    x86?  ( https://raw.githubusercontent.com/necrose99/necromancy-overlay/master/app-emulation/veil-wine/files/veil-wine32-setup.sh )
   AMD64? ( https://raw.githubusercontent.com/necrose99/necromancy-overlay/master/app-emulation/veil-wine/files/veil-wine64-setup.sh )" https://github.com/necrose99/necromancy-overlay/blob/master/app-emulation/veil-wine/files/veil-wine32-setup.sh

  LICENSE="gpl-3"
SLOT="0"
    KEYWORDS="~amd64 ~x86"
    Ewarn "useflags uninstall will FILE shread veilwine reinstall is shred+install alias"
    IUSE="+onbydefault +install  -uninstall -reinstall"

  DEPEND="app-emulation/winetricks
         app-misc/srm"
         # firejail
         # ebuilds for veil-framwork not yet done,
    
          RDEPEND="${DEPEND}
          install? ( veil_wine_setup )
          uninstall? ( shread_veilwine )
          reinstall? ( reinstall_veilwine )
          ~x86? ( veil_wine_setup_x86 )
          ~amd64? ( veil_wine_setup_64 )"

S="${WORKDIR}/${PN}"
dir_prepair () {
  dodir /opt/veilwine
  doexe /opt/bin/veil-wine32-setup.sh
  dosym veil-wine32-setup
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
  

reinstall_veilwine() {
  shread_veilwine 
  veil_wine_setup
}
shread_veilwine() {
Echo "Setting the world Onfire ***shreading your copy of wine for veil usage *****"
Echo "***shreading for your protection "
srm -r /opt/veilwine/*
}

pkg_postinst() {
	elog "you'll need to add youself to veilusers group to run the "build" of wine"
	ewarn "after you have ziped your payloads veil framwork , its wise to run the ebuild with reinstall to cleanup"
  elog "rember veil should be used for pentesting, or Security Research"
  ewarn "Pentest for good of Information Security , -Should you be a fool to abuse this- the Police/athorities wont have a sence of humor "
}

