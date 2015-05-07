# Copyright 2005-2006 Mike Nerone
# Distributed under the terms of the GNU General Public License v2
# Package: parent-kerne.eclass
# Version: 0.2
# Author: Mike Nerone <mike@nerone.org>

# This eclass makes it easy to make a custom-patched kernel ebuild that is based
# on an existing kernel ebuild in the portage tree. It inherits pretty much
# everything from this parent ebuild (if it exists, that is - otherwise, it does
# the best it can by simply subclassing kernel-2).
#
# There are two ways to specify the parent ebuild:
#
# 1. The intended way: it is automatically determined from the name of the child
#    ebuild (i.e. your customized one).  This is best explained with an example:
#    if you name your customized package "hardened+somename-sources", then this
#    eclass will remove the "+somename" part and automatically use
#    "hardened-sources" as its parent. The "somename" part is completely
#    arbitrary (you can even use multiple +'s and just list all your custom
#    patch names if you don't mind the lengths of the resulting filenames ;D).
#
# 2. You can pecify a parent package name in the PARENT_KERNEL_PN environment
#    variable before inheriting this eclass. This is simply a package name (e.g.
#    "gentoo-sources").
#
# The version of the parent package is assumed to be the same as that of the
# child. It's not possible to override this because there is too much magic in
# kernel-2.eclass that depends on it.
#
# By default, the category of the parent package is assumed to be "sys-kernel"
# and the ebuild is assumed to be in your main portage tree (PORTDIR).  You can
# override those assumptions with PARENT_KERNEL_CATEGORY and
# PARENT_KERNEL_PORTDIR in the very rare instance that that's necessary. In any
# case, if the resulting ebuild does not exist, any operations other than an
# unmerge will fail.
#
# If the parent ebuild needs any files from the parent package's
# FILESDIR, they must be linked or copied into the child's (and the child ebuild
# digested afterward). The easiest way to do this is with something like:
#
# # cd /path/to/your/overlay/sys-kernel/<child-package>/files
# # for file in `ls /usr/portage/sys-kernel/<parent-package>/files/* | grep -v '\/digest-'`; do ln -s $file; done
# # ebuild ../<child-ebuild> digest
#
# Please be aware that using this eclass bypasses checks of all source files
# (i.e. SRC_URI and FILESDIR files) against the parent's digests. I don't see a
# way around this (short of ugly kludges), but it is very unlikely to cause a
# problem because of 1) the QA used by the Gentoo devs to make sure such
# inconsistencies don't get into the tree/mirrors; and 2) for any such mismatch,
# the error is very likely to be a non-updated digest, not a bad source file.

# This eclass's whole purpose is to provide a single useful function:
#
# add_kernel_patch PATCH_LOCATION [PATCH_NAME [HOMEPAGE]]
#
# PATCH_LOCATION can be a URL for the patch file (any type Portage knows how to
#   handle), an absolute path to the file, or a path relative to FILESDIR.
# PATCH_NAME will be used in constructing a new package DESCRIPTION based on the
#   parent package's. Note: if you set DESCRIPTION before inheriting
#   parent-kernel, it will be preserved.
# HOMEPAGE will be added to the package's HOMEPAGE list, which is initially
#   inherited from the parent package. Again, HOMEPAGE will be preserved if set
#   before inheriting parent-kernel.

# Example ebuild (yes, it really does something useful with just
# two commands):
#
# ===============================================================================
#   inherit parent-kernel
#   add_kernel_patch                                                            \
#       'http://www.ultramegakernelpatch.com/ultramegakernelpatch-${PV}.tar.gz' \
#       'UltraMega'                                                             \
#       'http://www.ultramegakernelpatch.com/'
# ===============================================================================
#
# Note: you can actually pre-populate future versions/revisions of your ebuild,
# all identical (dont't create *too* many (perhaps 50), lest it slow down your
# portage operations too much). Since each inherits everything, including
# KEYWORDS, from the parent ebuild, each will stabilize automatically when the
# corresponding parent ebuild does. As long as you utilize ${PV} in the patch
# location, this should never get you in trouble because the attempt to apply
# the missing patch (and therefore the whole build) will fail if the patch for a
# new kernel version is not yet available (or you have not put it in place if
# you're using a file path). Also note that the build will fail if a patch file
# is found but fails to apply cleanly (thanks to kernel-2.eclass, inheritance of
# which is enforced, by the way).

################################################################################

# add_kernel_patch is for use in the child ebuild. Usage details are outlined
# above.
add_kernel_patch() {
	local filepath

	local location="$1" name="$2" homepage="$3"

	if [[ "X${1}X" != "X${1/:\/\//}X" ]] ; then	# URL: download into DISTDIR
		SRC_URI="${SRC_URI} ${location}"
		filepath="${DISTDIR}/$(basename ${location})"
	elif [[ "X${1}X" != "X${1#/}X" ]]; then 	# Absolute path in filesystem
		filepath="${location}"
	else										# Assume relative to FILESDIR
		filepath="${FILESDIR}/${location}"
	fi
	UNIPATCH_LIST="${UNIPATCH_LIST} ${filepath}" # Append to patch list
	
	# Keep a list of the patch names that have been provided by the child. This
	# is used below to build a useful DESCRIPTION.
	if [[ -n "${name}" ]]; then
		if [[ $PARENT_KERNEL_PATCH_COUNT == 0 ]]; then
			PARENT_KERNEL_PATCH_NAMES="${name}"
		else
			PARENT_KERNEL_PATCH_NAMES="${PARENT_KERNEL_PATCH_NAMES}, ${name}"
		fi
	fi

	# Unless DESCRIPTION was provided explicitly by the child, use the parent's
	# with the child's patch-names appended.
	if [[ -z "${PARENT_KERNEL_PRESERVE_DESCRIPTION}" ]]; then
		if [[ -z "${PARENT_KERNEL_PATCH_NAMES}" ]]; then
			DESCRIPTION="${PARENT_KERNEL_DESCRIPTION} (custom-patched)"
		else
			DESCRIPTION="${PARENT_KERNEL_DESCRIPTION} (custom-patched: ${PARENT_KERNEL_PATCH_NAMES})"
		fi
	else
		DESCRIPTION="${PARENT_KERNEL_PRESERVE_DESCRIPTION}"
	fi

	# Unless HOMEPAGE was provided explicitly by the child, append the one
	# provided in the function call.
	if [[ -z "${PARENT_KERNEL_PRESERVE_HOMEPAGE}" ]]; then
		if [[ -n "${homepage}" ]]; then
			HOMEPAGE="${HOMEPAGE} ${homepage}"
		fi
	else
		HOMEPAGE="${PARENT_KERNEL_PRESERVE_HOMEPAGE}"
	fi
	
	# Keep a count of patches
	let PARENT_KERNEL_PATCH_COUNT=${PARENT_KERNEL_PATCH_COUNT}+1
}

# When we source the parent ebuild, DESCRIPTION and HOMEPAGE will be
# overwritten, so let's remember them before doing so.
[[ -n "${DESCRIPTION}" ]] && PARENT_KERNEL_PRESERVE_DESCRIPTION="${DESCRIPTION}"
[[ -n "${HOMEPAGE}"    ]] && PARENT_KERNEL_PRESERVE_HOMEPAGE="${HOMEPAGE}"

# Set default parent package category and portage directory unless explicitly
# provided by the child ebuild.
[[ -z "${PARENT_KERNEL_CATEGORY}" ]] && PARENT_KERNEL_CATEGORY="sys-kernel"
[[ -z "${PARENT_KERNEL_PORTDIR}"  ]] && PARENT_KERNEL_PORTDIR="${PORTDIR}"

# List of ebuild-type functions that will be allowed even if the parent ebuild
# does not exist (anymore?). I.e. those needed for unmerging.
local portage_unmerge_functions="
	pkg_setup
	pkg_prerm
	pkg_postrm
"
# List of ebuild-type functions that will *not* be allowed if the parent ebuild
# does not exist (anymore?).
local portage_other_functions="
	pkg_nofetch
	src_unpack
	src_compile
	src_test
	src_install
	pkg_preinst
	pkg_postinst
	pkg_config
"
# And for convenience, a list of all of the ebuild-type functions.
local portage_functions="
	${portage_unmerge_functions}
	${portage_other_functions}
"

PARENT_KERNEL_PATCH_COUNT=0

# Determine parent kernel ebuild.
if [[ -z "${PARENT_KERNEL_PN}" && "${PN}" =~ '^([^+]+)\+([^-]+)(-.+)$' ]]; then
	PARENT_KERNEL_PN="${BASH_REMATCH[1]}${BASH_REMATCH[3]}"
fi
PARENT_KERNEL_EBUILD="${PARENT_KERNEL_PORTDIR}/${PARENT_KERNEL_CATEGORY}/${PARENT_KERNEL_PN}/${PARENT_KERNEL_PN}-${PVR}.ebuild"

# If we never figured out a good PN for the parent kernel, then
# PARENT_KERNEL_EBUILD is invalid.
if [[ -z "${PARENT_KERNEL_PN}" ]]; then
	unset PARENT_KERNEL_EBUILD
fi

# Calling this function prohibits build-related activity by setting all build
# functions to die with the error message supplied.
die_on_build() {
	local die_message="$1"
	for function in ${portage_other_functions}; do
		eval "
			${function} () {
				die "${die_message}"
			}
		"
	done
}

# Either source the parent ebuild or inherit kernel-2 directly. Prohibit
# building accordingly.
if [[ -n "${PARENT_KERNEL_PN}" && -f "${PARENT_KERNEL_EBUILD}" ]]; then
	source "${PARENT_KERNEL_EBUILD}"
else
	ETYPE="sources"
	inherit kernel-2
	if [[ -z "${PARENT_KERNEL_PN}" ]]; then
		die_on_build "Package name format invalid - unable to determine parent"
	else
		die_on_build "Parent ebuild \"${PARENT_KERNEL_EBUILD}\" does not exist"
	fi
fi

# Sanity checks on inheritance.
if [[ ! "${INHERITED}" =~ "\bkernel-2\b" ]]; then
	die_on_build "The ${ECLASS} eclass only supports parent ebuilds that inherit the kernel-2 eclass"
fi
if [[ "${INHERITED}" =~ "\b${ECLASS}\b.*\b${ECLASS}\b" ]]; then
	die_on_build "${ECLASS} was inherited more than once but does not support nesting"
fi

# Remember the parent kernel's description.
PARENT_KERNEL_DESCRIPTION="${DESCRIPTION}"

# Inherit the parent's ebuild functions as those of this eclass to preserve any
# customization done in the parent ebuild...
for function in ${portage_functions}; do
	eval "${ECLASS}_$(declare -f $function)"
done

# ...then export those functions to the child.
EXPORT_FUNCTIONS ${portage_functions}
