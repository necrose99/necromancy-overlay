# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xen-tools/xen-tools-9999.ebuild,v 1.7 2011/10/23 10:49:29 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE='xml,threads'

IPXE_TARBALL_URL="http://dev.gentoo.org/~idella4/tarballs/ipxe.tar.gz"
XEN_SEABIOS_URL="http://dev.gentoo.org/~idella4/tarballs/seabios-dir-remote-20130720.tar.gz"

if [[ $PV == *9999 ]]; then
	KEYWORDS=""
	EGIT_REPO_URI_MAIN="git://xenbits.xen.org/xen.git"
	EGIT_REPO_URI_QEMU="git://xenbits.xen.org/qemu-upstream-unstable.git"
	EGIT_REPO_URI_TRAD="git://xenbits.xen.org/qemu-xen-unstable.git"
	EGIT_REPO_URI_SEAB="git://xenbits.xen.org/seabios.git"
	EGIT_REPO_URI_IPXE="git://git.ipxe.org/ipxe.git"
	S="${WORKDIR}/xen"
	live_eclass="git-2"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="http://bits.xensource.com/oss-xen/release/${PV}/xen-${PV}.tar.gz
	$IPXE_TARBALL_URL
	$XEN_SEABIOS_URL"
	S="${WORKDIR}/xen-${PV}"
fi

inherit bash-completion-r1 eutils flag-o-matic multilib python-single-r1 toolchain-funcs udev ${live_eclass}

DESCRIPTION="Xend daemon and tools"
HOMEPAGE="http://xen.org/"
DOCS=( README docs/README.xen-bugtool docs/ChangeLog )

LICENSE="GPL-2"
SLOT="0"
IUSE="api custom-cflags debug doc flask hvm qemu ocaml python pygrub screen static-libs xend"

REQUIRED_USE="hvm? ( qemu )"

CDEPEND="dev-libs/lzo:2
	dev-libs/yajl
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pypam[${PYTHON_USEDEP}]
	sys-libs/zlib
	sys-power/iasl
	dev-ml/findlib
	hvm? ( media-libs/libsdl )
	${PYTHON_DEPS}
	api? ( dev-libs/libxml2
		net-misc/curl )
	pygrub? ( ${PYTHON_DEPS//${PYTHON_REQ_USE}/ncurses} )"

DEPEND="${CDEPEND}
	sys-devel/bin86
	sys-devel/dev86
	dev-lang/perl
	app-misc/pax-utils
	dev-python/markdown
	doc? (
		app-doc/doxygen
		dev-tex/latex2html[png,gif]
		media-gfx/graphviz
		dev-tex/xcolor
		media-gfx/transfig
		dev-texlive/texlive-latexextra
		virtual/latex-base
		dev-tex/latexmk
		dev-texlive/texlive-latex
		dev-texlive/texlive-pictures
		dev-texlive/texlive-latexrecommended
	)
	hvm? ( x11-proto/xproto
		!net-libs/libiscsi )
	qemu? ( x11-libs/pixman )"

RDEPEND="${CDEPEND}
	sys-apps/iproute2
	net-misc/bridge-utils
	ocaml? ( >=dev-lang/ocaml-4 )
	screen? (
		app-misc/screen
		app-admin/logrotate
	)
	virtual/udev"

# hvmloader is used to bootstrap a fully virtualized kernel
# Approved by QA team in bug #144032
QA_WX_LOAD="usr/lib/xen/boot/hvmloader"

RESTRICT="test"

pkg_setup() {
	python-single-r1_pkg_setup
	export "CONFIG_LOMOUNT=y"
	export "CONFIG_TESTS=n"

	if has_version dev-libs/libgcrypt; then
		export "CONFIG_GCRYPT=y"
	fi

	if use qemu; then
		export "CONFIG_IOEMU=y"
	else
		export "CONFIG_IOEMU=n"
	fi

	if ! use x86 && ! has x86 $(get_all_abis) && use hvm; then
		eerror "HVM (VT-x and AMD-v) cannot be built on this system. An x86 or"
		eerror "an amd64 multilib profile is required. Remove the hvm use flag"
		eerror "to build xen-tools on your current profile."
		die "USE=hvm is unsupported on this system."
	fi

	if [[ -z ${XEN_TARGET_ARCH} ]] ; then
		if use x86 && use amd64; then
			die "Confusion! Both x86 and amd64 are set in your use flags!"
		elif use x86; then
			export XEN_TARGET_ARCH="x86_32"
		elif use amd64 ; then
			export XEN_TARGET_ARCH="x86_64"
		else
			die "Unsupported architecture!"
		fi
	fi

	use api     && export "LIBXENAPI_BINDINGS=y"
	use flask   && export "FLASK_ENABLE=y" "XSM_ENABLE=y"
}

src_unpack() {
	EGIT_REPO_URI=${EGIT_REPO_URI_MAIN} \
		EGIT_SOURCEDIR=${S} git-2_src_unpack

	EGIT_REPO_URI=${EGIT_REPO_URI_QEMU} \
		EGIT_SOURCEDIR=${S}/tools/qemu-xen-dir git-2_src_unpack

	EGIT_REPO_URI=${EGIT_REPO_URI_TRAD} \
		EGIT_SOURCEDIR=${S}/tools/qemu-xen-traditional-dir git-2_src_unpack

	EGIT_REPO_URI=${EGIT_REPO_URI_SEAB} \
		EGIT_SOURCEDIR=${S}/tools/firmware/seabios-dir \
		EGIT_COMMIT="1.7.1-stable-xen" \
		EGIT_BRANCH="1.7.1-stable-xen" git-2_src_unpack

	EGIT_REPO_URI=${EGIT_REPO_URI_IPXE} \
		EGIT_SOURCEDIR=${S}/tools/firmware/etherboot/ipxe git-2_src_unpack
}

src_prepare() {
	sed -e 's/-Wall//' -i Config.mk || die "Couldn't sanitize CFLAGS"

	# Drop .config
	sed -e '/-include $(XEN_ROOT)\/.config/d' -i Config.mk || die "Couldn't drop"
	# Xend
	if ! use xend; then
		sed -e 's:xm xen-bugtool xen-python-path xend:xen-bugtool xen-python-path:' \
			-i tools/misc/Makefile || die "Disabling xend failed"
		sed -e 's:^XEND_INITD:#XEND_INITD:' \
			-i tools/examples/Makefile || die "Disabling xend failed"
	fi

	# if the user *really* wants to use their own custom-cflags, let them
	if use custom-cflags; then
		einfo "User wants their own CFLAGS - removing defaults"

		# try and remove all the default cflags
		find "${S}" \( -name Makefile -o -name Rules.mk -o -name Config.mk \) \
			-exec sed \
				-e 's/CFLAGS\(.*\)=\(.*\)-O3\(.*\)/CFLAGS\1=\2\3/' \
				-e 's/CFLAGS\(.*\)=\(.*\)-march=i686\(.*\)/CFLAGS\1=\2\3/' \
				-e 's/CFLAGS\(.*\)=\(.*\)-fomit-frame-pointer\(.*\)/CFLAGS\1=\2\3/' \
				-e 's/CFLAGS\(.*\)=\(.*\)-g3*\s\(.*\)/CFLAGS\1=\2 \3/' \
				-e 's/CFLAGS\(.*\)=\(.*\)-O2\(.*\)/CFLAGS\1=\2\3/' \
				-i {} + || die "failed to re-set custom-cflags"
	fi

	if ! use pygrub; then
		sed -e '/^SUBDIRS-y += pygrub$/d' -i tools/Makefile || die
	fi

	if ! use python; then
		sed -e '/^SUBDIRS-y += python$/d' -i tools/Makefile || die
	fi

	# Disable hvm support on systems that don't support x86_32 binaries.
	if ! use hvm; then
		sed -e '/^CONFIG_IOEMU := y$/d' -i config/*.mk || die
		sed -e '/SUBDIRS-$(CONFIG_X86) += firmware/d' -i tools/Makefile || die
	fi

	# Don't bother with qemu, only needed for fully virtualised guests
	if ! use qemu; then
		sed -e "/^CONFIG_IOEMU := y$/d" -i config/*.mk || die
		sed -e "s:install-tools\: tools/ioemu-dir:install-tools\: :g" -i Makefile || die
	fi

	# Fix build for gcc-4.6
	local WERROR=(
		"tools/libxl/Makefile"
		"tools/xenstat/xentop/Makefile"
		)
	for mf in ${WERROR[@]} ; do
		sed -e "s:-Werror::g" -i $mf || die
	done

	# Bug 472438
	sed -e 's:^BASH_COMPLETION_DIR ?= $(CONFIG_DIR)/bash_completion.d:BASH_COMPLETION_DIR ?= $(SHARE_DIR)/bash-completion:' \
		-i Config.mk || die

	use flask || sed -e "/SUBDIRS-y += flask/d" -i tools/Makefile || die
	use api   || sed -e "/SUBDIRS-\$(LIBXENAPI_BINDINGS) += libxen/d" -i tools/Makefile || die

	# why need LC_ALL=C
	sed -e 's:$(MAKE) PYTHON=$(PYTHON) subdirs-$@:LC_ALL=C "$(MAKE)" PYTHON=$(PYTHON) subdirs-$@:' -i tools/firmware/Makefile || die

	epatch_user
}

src_configure() {
	econf \
		--enable-lomount \
		--disable-werror
}

src_compile() {
	export VARTEXFONTS="${T}/fonts"
	local myopt
	use debug && myopt="${myopt} debug=y"

	use custom-cflags || unset CFLAGS
	if test-flag-CC -fno-strict-overflow; then
		append-flags -fno-strict-overflow
	fi

	unset LDFLAGS
	unset CFLAGS
	emake V=1 CC="$(tc-getCC)" LD="$(tc-getLD)" AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)" -C tools ${myopt}

	# add figs if media-gfx/transfig enabled
	use doc && emake -C docs txt html figs
	emake -C docs man-pages
}

src_install() {
	# Override auto-detection in the build system, bug #382573
	export INITD_DIR=/tmp/init.d
	export CONFIG_LEAF_DIR=../tmp/default

	# Let the build system compile installed Python modules.
	local PYTHONDONTWRITEBYTECODE
	export PYTHONDONTWRITEBYTECODE

	emake DESTDIR="${D}" DOCDIR="/usr/share/doc/${PF}" \
		XEN_PYTHON_NATIVE_INSTALL=y install-tools

	# Fix the remaining Python shebangs.
	python_fix_shebang "${D}"

	# Remove RedHat-specific stuff
	rm -rf "${D}"/tmp || die

	# uncomment lines in xl.conf
	sed -e 's:^#autoballoon=1:autoballoon=1:' \
		-e 's:^#lockfile="/var/lock/xl":lockfile="/var/lock/xl":' \
		-e 's:^#vifscript="vif-bridge":vifscript="vif-bridge":' \
		-i tools/examples/xl.conf  || die

	# Reset bash completion dir; Bug 472438
	mv "${D}"bash-completion "${D}"usr/share/ || die

	if use doc; then
		emake DESTDIR="${D}" DOCDIR="/usr/share/doc/${PF}" install-docs

		docinto pdf
		dodoc ${DOCS[@]}
		[ -d "${D}"/usr/share/doc/xen ] && mv "${D}"/usr/share/doc/xen/* "${D}"/usr/share/doc/${PF}/html
	fi

	rm -rf "${D}"/usr/share/doc/xen/
	doman docs/man?/*

	if use xend; then
		newinitd "${FILESDIR}"/xend.initd-r2 xend
	fi
	newconfd "${FILESDIR}"/xendomains.confd xendomains
	newconfd "${FILESDIR}"/xenstored.confd xenstored
	newconfd "${FILESDIR}"/xenconsoled.confd xenconsoled
	newinitd "${FILESDIR}"/xendomains.initd-r2 xendomains
	newinitd "${FILESDIR}"/xenstored.initd xenstored
	newinitd "${FILESDIR}"/xenconsoled.initd xenconsoled

	if use screen; then
		cat "${FILESDIR}"/xendomains-screen.confd >> "${D}"/etc/conf.d/xendomains || die
		cp "${FILESDIR}"/xen-consoles.logrotate "${D}"/etc/xen/ || die
		keepdir /var/log/xen-consoles
	fi

	# Move files built with use qemu, Bug #477884
	if [[ "${ARCH}" == 'amd64' ]] && use qemu; then
		mkdir -p "${D}"usr/$(get_libdir)/xen/bin || die
		mv "${D}"usr/lib/xen/bin/* "${D}"usr/$(get_libdir)/xen/bin/ || die
	fi

	# For -static-libs wrt Bug 384355
	if ! use static-libs; then
		rm -f "${D}"usr/$(get_libdir)/*.a "${D}"usr/$(get_libdir)/ocaml/*/*.a
	fi

	# xend expects these to exist
	keepdir /var/run/xenstored /var/lib/xenstored /var/xen/dump /var/lib/xen /var/log/xen

	# for xendomains
	keepdir /etc/xen/auto

	# Temp QA workaround
	dodir "$(udev_get_udevdir)"
	mv "${D}"/etc/udev/* "${D}/$(udev_get_udevdir)"
	rm -rf "${D}"/etc/udev

	# Remove files failing QA AFTER emake installs them, avoiding seeking absent files
	find "${D}" \( -name openbios-sparc32 -o -name openbios-sparc64 \
		-o -name openbios-ppc -o -name palcode-clipper \) -delete || die
}

pkg_postinst() {
	elog "Official Xen Guide and the unoffical wiki page:"
	elog " http://www.gentoo.org/doc/en/xen-guide.xml"
	elog " http://gentoo-wiki.com/HOWTO_Xen_and_Gentoo"

	if [[ "$(scanelf -s __guard -q "${PYTHON}")" ]] ; then
		echo
		ewarn "xend may not work when python is built with stack smashing protection (ssp)."
		ewarn "If 'xm create' fails with '<ProtocolError for /RPC2: -1 >', see bug #141866"
		ewarn "This problem may be resolved as of Xen 3.0.4, if not post in the bug."
	fi

	# TODO: we need to have the current Python slot here.
	if ! has_version "dev-lang/python[ncurses]"; then
		echo
		ewarn "NB: Your dev-lang/python is built without USE=ncurses."
		ewarn "Please rebuild python with USE=ncurses to make use of xenmon.py."
	fi

	if has_version "sys-apps/iproute2[minimal]"; then
		echo
		ewarn "Your sys-apps/iproute2 is built with USE=minimal. Networking"
		ewarn "will not work until you rebuild iproute2 without USE=minimal."
	fi

	if ! use hvm; then
		echo
		elog "HVM (VT-x and AMD-V) support has been disabled. If you need hvm"
		elog "support enable the hvm use flag."
		elog "An x86 or amd64 multilib system is required to build HVM support."
	fi

	if use xend; then
		elog"";elog "xend capability has been enabled and installed"
	fi

	if use qemu; then
		elog "The qemu-bridge-helper is renamed to the xen-bridge-helper in the in source"
		elog "build of qemu.  This allows for app-emulation/qemu to be emerged concurrently"
		elog "with the qemu capable xen.  It is up to the user to distinguish between and utilise"
		elog "the qemu-bridge-helper and the xen-bridge-helper.  File bugs of any issues that arise"
	fi

	if grep -qsF XENSV= "${ROOT}/etc/conf.d/xend"; then
		echo
		elog "xensv is broken upstream (Gentoo bug #142011)."
		elog "Please remove '${ROOT%/}/etc/conf.d/xend', as it is no longer needed."
	fi
}
