# Copyright open-overlay 2015 by Alex

EAPI="5"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"
K_LONGTERM="yes"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Longterm full sources for the Linux kernel"
HOMEPAGE="http://www.kernel.org"
SRC_URI="${KERNEL_URI}"

KEYWORDS="alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE="deblob"
