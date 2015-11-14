# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/metasploit_data_models/metasploit_data_models-0.17.0.ebuild,v 1.3 2014/07/09 21:13:54 zerochaos Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

inherit ruby-fakegem # git-r3 # https://github.com/CenturyLinkLabs/flatcar.git" 

DESCRIPTION="Rails development environment manager"
HOMEPAGE="https://github.com/CenturyLinkLabs/flatcar.git"
SRC_URI="https://rubygems.org/gems/${P}.gem
https://github.com/CenturyLinkLabs/flatcar/archive/master.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/celluloid-0.16*
		>=dev-ruby/celluloid-io-0.16*
		>=-ruby/timers:4"

#celluloid ~> 0.16.0
#celluloid-io ~> 0.16.1

#gem.add_dependency 'gli', '2.13.1'
  #gem.add_dependency 'rails', '~> 4.2'
  #gem.add_development_dependency 'rake', '~> 10.4'
 # gem.add_development_dependency 'rspec', '~> 3.3'
  #gem.add_development_dependency 'simplecov', '~> 0.10.0'
  #gem.add_development_dependency 'simplecov-rcov', '~> 0.2.3'
 # gem.add_development_dependency 'rdoc', '~> 4.2'
