# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

inherit multilib ruby-fakegem

DESCRIPTION="a Vagrant plugin that allows provision Linux Containers as an alternative to  VirtualBox"
HOMEPAGE="https://github.com/fgrehm/vagrant-lxc"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64 ~arm ~x86"

ruby_add_rdepend "
|| ( >=!app-emulation/vagrant-1.5.2  >=!app-emulation/vagrant-bin-1.5.2 )
	>=app-emulation/lxc-0.7.5
	net-misc/bridge-utils
	net-misc/redir
"
