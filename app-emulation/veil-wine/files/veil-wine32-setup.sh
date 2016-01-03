## forking ebuild into script/s and a meta ebuild much to do

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $necrose99 exp veil wine setup metapackage, 
# DEPEND="app-emulation/winetricks , uses wine tricks to make a wine prefix, 
# however Converting to a more distro agnostic so veil enviorments 
## as well One can get a repeatable veil specific wine without having risks IE DUAL BOOT cp -symbloic links for files 
## MY REAL Windows shit ie steam games etc >>>> wine or wine prefixes...  and no one wants to be a derp and infect themselves. 
### so ./veilwine32 or 64 
# GUI nice but will be a few..... 
#cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
#options=(1 "Option 1" off    # any option can be set to default to "on"
         2 "Option 2" off
         3 "Option 3" off
         4 "Option 4" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
            echo "First Option"
            ;;
        2)
            echo "Second Option"
            ;;
        3)
            echo "Burn Veil Wine Enviorment Oh Noze the Police arz a coming..."
            ;; shread_veilwine
            
       4)
            echo "Copy Hashes file to cloud."
            ;;
        5)
            echo "Quit"
            ;;
    esac
done

if (( $EUID = 0 )); then
    mkdir /root/.veilwine32
    mydir=/.veilwine32
    myhome=/root/
    else
mydir=$(whoami)
myhome=/home/
dir_prepair () {
  mkdir /$myhome/$mydir/.veilwine32
}
veil_wine_setup_x86 () {
	WINEPREFIX=~/$myhome/$mydir/.veilwine32 WINEARCH=win32 wine32 winecfg
	env WINEPREFIX=~/$myhome/$mydir/.veilwine32 wineboot -u
	export WINEPREFIX=~/$myhome/$mydir/.veilwine32
  }
 # Basic 32-bit Python-in-Wine environment
sh winetricks corefonts vcrun6  allfonts
wget -N https://www.python.org/ftp/python/2.7.11/python-2.7.11.msi
wine msiexec /i python-2.7.5.msi /quiet

do_pip () {
# Pip
wget -N https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
wine ~/.wine/drive_c/Python27/python.exe ez_setup.py
wget -N https://raw.github.com/pypa/pip/master/contrib/get-pip.py
wine ~/$myhome/$mydir/.veilwine32/drive_c/Python27/Python27/python.exe get-pip.py
}
# Dependency: Jinja2
wine ~/$myhome/$mydir/.veilwine32/drive_c/Python27/Scripts/pip.exe install jinja2

# Dependency:  lxml requires Visual Studio, let's use a prebuilt binary instead
wget -N https://pypi.python.org/packages/2.7/l/lxml/lxml-3.2.3.win32-py2.7.exe
wine ~/$myhome/$mydir/.veilwine32/drive_c/Python27/Scripts/easy_install.exe lxml-3.2.3.win32-py2.7.exe

# Dependency: Windows specific
wine ~/$myhome/$mydir/.veilwine32/ install pyreadline

# Dependency: python-imaging
wine ~/$myhome/$mydir/.veilwine32/Python27/Scripts/pip.exe install pil
wine ~/$myhome/$mydir/.veilwine32/Python27/Scripts/pip.exe pypiwin32  # pywin32 replaces the nag of getting py-win32.

# Pyinstaller
wine ~/$myhome/$mydir/.veilwine32/drive_c/Python27/Scripts/pip.exe install pyinstaller
cp scripts/mailpile mailpile.py
wine ~/$myhome/$mydir/.veilwine32/drive_c/Python27/Scripts/pyinstaller.exe --hidden-import=mailpile.jinjaextensions mailpile.py


reinstall_veilwine() {
  shread_veilwine 
  veil_wine_setup_x86
}
shread_veilwine() {
Echo "Setting the world Onfire ***shreading your copy of wine for veil*******"
Echo "***shreading for your protection "
srm -r /$myhome/$mydir/.veilwine32/*
}

pkg_postinst() {
echo "WARNING!!!: Dont get Caught , the police wont even let you have a solar calulator when thier though with you; should you be foolish abuse this."
}

