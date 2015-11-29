# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Configure the brightness of the keyboard's backlight on ASUS
laptops."
HOMEPAGE="http://projects.flogisoft.com/asus-keyboard-backlight/"
SRC_URI="http://projects.flogisoft.com/${PN}/download/${PN}_${PV}_src.tar.gz
https://launchpad.net/${PN}/trunk/0.1/+download/${PN}_${PV}_0.1_src.tar.gz
${FILESDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~*"
IUSE="-sys-apps/systemd"

RDEPEND="${DEPEND}
	dev-lang/python
	sys-power/acpid
	systemd? ( sys-apps/systemd )"

S="${WORKDIR}/asus-kbd-backlight-${PV}"
# write for systemD or other init Support , changed to bin path & Add Symlinks if using openrc,etc. better to be init neutral. 
src_install(){
	#Install
	#$1 : the output path, if different of /
	#ACPI events
	dodir /etc/acpi/events/
	cp -v ./events/* "$D"/etc/acpi/events/
	#ACPI script
	cp -v ./code/asus-kbd-backlight.py "$D"/usr/bin/asus-kbd-backlight.py
	dosym /usr/bin/asus-kbd-backlight.py "$D"/etc/acpi/asus-kbd-backlight.py
	chmod 755 "$D"/usr/bin/asus-kbd-backlight.py
	#Resume script
	dodir /etc/pm/sleep.d/
	cp -v ./code/asus-kbd-backlight_resume.sh "$D"/usr/bin/asus-kbd-backlight_resume
	dosym /usr/bin/asus-kbd-backlight_resume /etc/pm/sleep.d/80_asus-kbd-backlight
	chmod 755 "$D"/usr/bin/asus-kbd-backlight_resume
	#Init script
	dodir	/etc/init.d/
	cp -v ./code/asus-kbd-backlight_init.sh  "$D"/usr/bin/asus-kbd-backlight
	dosym /usr/bin/asus-kbd-backlight /etc/init.d/asus-kbd-backlight
	chmod 755 "$D"/usr/bin/asus-kbd-backlight

	#Bak
	dodir /var/lib/asus-kbd-backlight/
	echo 1 > "$D"/var/lib/asus-kbd-backlight/brightness
}
## ADD In Systemd Gentoo Devs Say its better to Install them all.
# write for systemD use= if not using SystemD or going to Migrate to it no point in adding extra crap if user dont want it.
pkg_service() {
	if USE="systemd?"
inherit systemd
		# write the systemd unit file
		cat <<-'EOF' > /usr/lib/systemd/system/asus-kbd-backlight.service
		[Unit]
		Description=Allow user access to keyboard backlight
		After=systemd-udevd.service
		
		[Service]
		ExecStart=/usr/bin/asus-kbd-backlight allowusers
		
		[Install]
		WantedBy=multi-user.target 
		EOF

dosym   /usr/lib/systemd/system/asus-kbd-backlight.service /etc/systemd/system/asus-kbd-backlight.service
systemd_enable_service /usr/lib/systemd/system/asus-kbd-backlight.service 
	else
	fi
}
