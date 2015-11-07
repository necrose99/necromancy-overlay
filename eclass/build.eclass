# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: build.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/build.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

case ${EAPI} in
	5)	: ;;
	*)	die "build.eclass: unsupported EAPI=${EAPI:-0}" ;;
esac

if [[ ${___ECLASS_ONCE_BUILD} != "recur -_+^+_- spank" ]]; then
___ECLASS_ONCE_BUILD="recur -_+^+_- spank"

inherit utils

EXPORT_FUNCTIONS src_compile

: ${IUSE:="${IUSE} build"}

# @FUNCTION: src_compile
# @USAGE:
# @DESCRIPTION: Configure and build the package.
build_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	# Disable the sandbox for this dir
	addwrite "/boot"

	local version_h_name="usr/src/linux-${KV_FULL}/include/linux"
	local version_h="${ROOT}${version_h_name}"

	if [ -f "${version_h}" ]; then
		einfo "Discarding previously installed version.h to avoid collisions"
		addwrite "/${version_h_name}"
		rm -f "${version_h}"
	fi

	cd "${S}" || die "${RED}cd ${S} failed${NORMAL}"
	dodir /usr/src
	echo ">>> Copying sources ..."

	move "${WORKDIR}/linux-${KV_FULL}" "${D}/usr/src"

	if use build; then
		# Find out some info..
		eval $(head -n 4 Makefile | sed -e 's/ //g')
		local ARCH=$(uname -m | sed -e s/i.86/i386/g)
		local FULLVER=${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}
		local MODULESUPPORT=$(grep "CONFIG_MODULES=y" .config 2>/dev/null)

		if [[ -e .config && -e arch/${ARCH}/boot/bzImage ]]; then
			ISNEWER=$(find .config -newer arch/${ARCH}/boot/bzImage 2>/dev/null)
		else
			if ! [[ -e .config ]]; then
				ISNEWER="noconfig"
			else
				ISNEWER="yes"
			fi
		fi

		if [[ -e .version ]]; then
			BUILDNO=$(cat .version)
		else
			BUILDNO="0"
		fi

		ebegin "Beginning installation procedure for ${RED}\"${FULLVER}\"${NORMAL}"
			if [[ ${ISNEWER} == "noconfig" ]]; then
				if [[ $(cat /proc/mounts | grep /boot) == "" && $(cat /etc/fstab | grep /boot) != "" ]]; then
					ebegin "  Boot partition unmounted, mounting"
						mount /boot
					eend $?
				fi

				get_config

			fi

			if [[ ${ISNEWER} != "" ]]; then
				ebegin " No kernel version found"
					if [[ -e /usr/src/linux/.version ]]; then
						einfo "  Found kernel version /usr/src/linux/.version"
							cat /usr/src/linux/.version > .version
					elif [[ -e /usr/src/linux-${KV_FULL}/.version ]]; then
						einfo "  Found kernel version /usr/src/linux-${KV_FULL}/.version"
							cat /usr/src/linux-${KV_FULL}/.version > .version
					fi
				eend $
				ebegin " Kernel build not uptodate, compiling"
					make bzImage 2>/dev/null
					if [[ ${MODULESUPPORT} != "" ]]; then
						einfo "  Module support in kernel detected, building modules"
							make modules 2>/dev/null
					fi
				eend $?
				BUILDNO=$(cat .version)
			fi

			ebegin " Merging kernel to system (Buildnumber: ${RED}${BUILDNO}${NORMAL})"
				einfo "  Copying bzImage to ${RED}\"/boot/vmlinuz-${FULLVER}-${BUILDNO}\"${NORMAL}"
					copy arch/${ARCH}/boot/bzImage /boot/vmlinuz-${FULLVER}-${BUILDNO}
				einfo "  Copying System.map to ${RED}\"/boot/System.map-${FULLVER}\"${NORMAL}"
					copy System.map /boot/System.map-${FULLVER}
				einfo "  Copying .config to ${RED}\"/boot/config-${FULLVER}\"${NORMAL}"
					copy .config /boot/config-${FULLVER}
				if [[ ${MODULESUPPORT} != "" ]]; then
					einfo "  Installing modules to ${RED}\"/lib/modules/${FULLVER}/\"${NORMAL}"
						make modules_install 2>/dev/null
				fi
				ebegin " Editing kernel entry in GRUB"
					if [[ -e "/etc/grub.d/10_linux" ]]; then
						grub2-mkconfig -o /boot/grub2/grub.cfg
					elif [[ -e "/etc/boot.conf" ]]; then
						boot-update
					fi
				eend $?
			eend $?

			if [[ -e /var/lib/module-rebuild/moduledb && $(cat /var/lib/module-rebuild/moduledb | wc -l) -ge 1 ]]; then
				ebegin " Looking for external kernel modules that need rebuilding"
					for EXTKERNMOD in $(sed -e 's/.:.://g' /var/lib/module-rebuild/moduledb); do
						if [[ $(find /boot/vmlinuz-${FULLVER}-${BUILDNO} -newer /var/db/pkg/${EXTKERNMOD}/environment.bz2 2>/dev/null) != "" ]]; then
							ebegin "  Recompiling outdated module ${RED}\"${EXTKERNMOD}\"${NORMAL}"
								emerge --oneshot =${EXTKERNMOD} 2>/dev/null
							eend $?
						fi
					done
				eend $?
			fi
		eend $?
	fi
}

fi
