# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $ Necrose99 Since upstream Switched to CMake this is a quick and hasty hack. till I get Source to build.

EAPI=5
inherit  eutils unpacker  flag-o-matic

DESCRIPTION="Convert on-the-fly between multiple input and output harddisk image types"
HOMEPAGE="https://www.pinguin.lu/xmount"
SRC_URI="
    x86?   ( http://ftp.us.debian.org/debian/pool/main/x/xmount/xmount_0.7.3-1+b1_i386.deb -> xmount-0.7.3-1.deb )
    AMD64? ( http://ftp.us.debian.org/debian/pool/main/x/xmount/xmount_0.7.3-1+b1_amd64.deb -> xmount-0.7.3-1.deb )
    arm64? ( http://ftp.us.debian.org/debian/pool/main/x/xmount/xmount_0.7.3-1+b1_arm64.deb-> xmount-0.7.3-1.deb )
    ppc? ( http://ftp.us.debian.org/debian/pool/main/x/xmount/xmount_0.7.3-1+b1_powerpc.deb -> xmount-0.7.3-1.deb )
    ppc64? ( http://ftp.us.debian.org/debian/pool/main/x/xmount/xmount_0.7.3-1+b1_ppc64el.deb -> xmount-0.7.3-1.deb )
    armfl? ( http://ftp.us.debian.org/debian/pool/main/x/xmount/xmount_0.7.3-1+b1_armhf.deb -> xmount-0.7.3-1.deb )
    mips? ( http://ftp.us.debian.org/debian/pool/main/x/xmount/xmount_0.7.3-1+b1_mips.deb -> xmount-0.7.3-1.deb )
    mipsel? ( http://ftp.us.debian.org/debian/pool/main/x/xmount/xmount_0.7.3-1+b1_mipsel.deb -> xmount-0.7.3-1.deb )
    armel?  ( http://ftp.us.debian.org/debian/pool/main/x/xmount/xmount_0.7.3-1+b1_armel.deb -> xmount-0.7.3-1.deb )
    "

LICENSE="GPL-3"
SLOT="0"
IUSE="+aff +ewf"

#unable to build, see the upstream bug: https://www.pinguin.lu/node/16
KEYWORDS="~amd64-linux ~x86-linux ~arm-Linux  ~arm64-Linux  ~mips-linux ~ppc-linux ~ppc64-linux  ~ia64-linux ~armel-linux ~mipsel-linux"

RDEPEND="sys-fs/fuse
	aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
  unpacker_src_unpack
	mkdir -p "${S}"
	mv "${WORKDIR}/usr" "${S}"
	}

src_install() {
	into /
	insinto /
	doins -r .
}

# Fixes permissions
	fperms +x /usr/bin/xmount
	fperms +x /usr/lib/xmount/libxmount_input_aaff.so
	fperms +x /usr/lib/xmount/libxmount_input_aewf.so
	fperms +x /usr/lib/xmount/libxmount_input_aff.so
	fperms +x /usr/lib/xmount/libxmount_input_ewf.so
	fperms +x /usr/lib/xmount/libxmount_input_raw.so
	fperms +x /usr/lib/xmount/libxmount_morphing_combine.so
	fperms +x /usr/lib/xmount/libxmount_morphing_raid.so
	fperms +x /usr/lib/xmount/libxmount_morphing_unallocated.so
	fperms044 /usr/share/doc/xmount/NEWS.gz
	fperms044 /usr/share/doc/xmount/README.gz
	fperms044 /usr/share/doc/xmount/changelog.Debian.gz
	fperms044 /usr/share/doc/xmount/changelog.gz
	fperms044 /usr/share/doc/xmount/copyright
	fperms044 /usr/share/man/man1/xmount.1.gz
elog "Xmount Binary from Debian Installed, a true from source is in the works"
