#!/bin/bash

# Assuming Mailpile is current directory

# Basic 32-bit Python-in-Wine environment
sudo add-apt-repository ppa:ubuntu-wine/ppa
sudo apt-get update
sudo apt-get install wine1.6
wget -N http://python.org/ftp/python/2.7.5/python-2.7.5.msi
wine msiexec /i python-2.7.5.msi /quiet

# Pip
wget -N https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
wine ~/.wine/drive_c/Python27/python.exe ez_setup.py
wget -N https://raw.github.com/pypa/pip/master/contrib/get-pip.py
wine ~/.wine/drive_c/Python27/python.exe get-pip.py

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

# Run mailpile.exe!
cp -r static/ dist/mailpile/
wine dist/mailpile/mailpile.exe

# or run Mailpile using the Python interpreter
wine cmd /c mp.cmd
