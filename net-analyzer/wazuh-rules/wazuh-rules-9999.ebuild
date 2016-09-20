# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="A tool to update  OSSEC Wazuh Ruleset, detect attacks, intrusions, software misuse, errors, malware, "
HOMEPAGE=" http://www.wazuh.com/ossec-ruleset/"
SRC_URI="https://raw.githubusercontent.com/wazuh/ossec-rules/master/ossec_ruleset.py"
# OSSEC Wazuh is a fork of OSSEC, uses elastic search logstash kibana , restapi newer things ossec didnt originaly have
# this just fetches and poplates rules....

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tools"

DEPEND=""
RDEPEND=">="



S="${WORKDIR}/wazuh-rules-${PV}"

src_install() {

	dodir /var/ossec/update/ruleset
	cp -R * "${ED}"/var/ossec/update/ruleset/ossec_ruleset.py|| die "Copy files failed"
	python_fix_shebang "${ED}"/var/ossec/update/ruleset/ossec_ruleset.py
	
  dosym /var/ossec/update/ruleset/ossec_ruleset.py /usr/bin/ossec_ruleset

}
### populate the rules
pkg_postinst() {
 einfo "running wazuh ossec-rules , may take up to a few mins to dowload & update"
python path/to/the/python_script.py
	elog "wazuh ossec_ruleset installed ,note you may wish to Cron task this"
}
