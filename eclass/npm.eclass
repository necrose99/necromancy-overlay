# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: npm.eclass
# @MAINTAINER:
# mjo@gentoo.org
# @AUTHOR:
# Michael Orlitzky <mjo@gentoo.org>
# @BLURB: Common build functions for npm (NodeJS) packages.
# @DESCRIPTION:
# Most javascript packages support NodeJS and can be installed using its
# package manager, npm. All packages installable through npm have similar
# test/install procedures, and this eclass automates that in the common
# case.
#
# We provide three phase functions: src_install, src_test, and
# src_unpack.

inherit multilib

case "${EAPI:-0}" in
	5)
		;;
	*)
		die "${ECLASS}: Unsupported eapi (EAPI=${EAPI})"
		;;
esac

EXPORT_FUNCTIONS src_install src_test src_unpack

# We need npm to test the package, but in theory one could remove it
# afterwards. Just assume that all packages support testing (they
# should, through npm).
IUSE="test"

# Can the RDEPEND be hidden behind a IUSE="+nodejs"?
RDEPEND="net-libs/nodejs"
DEPEND="test? ( net-libs/nodejs[npm] )"

# By default, set the HOMEPAGE to the project's npm page.
# This should probably be overridden in the ebuild.
[[ -z "${HOMEPAGE}" ]] && HOMEPAGE="https://www.npmjs.com/package/${PN}"

# Everything in the npm registry can be fetched at a predictable
# URL. Default to that URL and let the ebuilds override it.
[[ -z "${SRC_URI}" ]] && SRC_URI="https://registry.npmjs.org/${PN}/-/${P}.tgz"


# @FUNCTION: npm_add_rdepend
# @USAGE: npm_add_rdepend <dependencies>
# @DESCRIPTION:
# Adds the specified dependencies, with use condition(s) to RDEPEND. Use
# this instead of specifying your runtime deps in RDEPEND. Dependencies
# added with npm_add_rdepend() are also considered when building a
# package with USE=test enabled. The format is identical to (R)DEPEND.
#
npm_add_rdepend(){
	local dependency="${1}"

	RDEPEND="${RDEPEND} $dependency"

	# Add the dependency as a test dep since we need to run the code
	# in order to test it.
	DEPEND="${DEPEND} test? ( ${dependency} )"
}


# @FUNCTION: npm_module_dir
# @RETURN: the global path where this package should be installed
# @DESCRIPTION:
# NodeJS searches a number of locations for installed packages. The
# upstream developers don't believe in global packages, so this location
# is the only one where we can safely install a package globally and have
# NodeJS find it (without using the NODE_PATH environment variable).
#
npm_module_dir(){
	echo "/usr/$(get_libdir)/node/${PN}"
}


# @FUNCTION: npm_doins
# @RETURN: npm_doins <files>
# @DESCRIPTION:
# Install the given files into the location returned by the
# npm_module_dir function.
#
npm_doins(){
	insinto "$(npm_module_dir)"
	doins "$@"
}


npm_src_install(){
	# Set nullglob before this call so that it doesn't fail when a
	# package ships no *.js files. To support bower, component, etc. we
	# could also install their json files here.
	shopt -s nullglob
	npm_doins *.js package.json
	shopt -u nullglob

	[[ -d lib ]] && npm_doins -r lib

	# Get rid of any makefiles before running the default src_install
	# function. We want the half of it that installs the docs, not the
	# half that runs make.
	rm -f GNUmakefile [Mm]akefile || die "failed to remove makefiles"
	default_src_install
}


npm_src_test(){
	npm test || die "npm test suite failed"
}


npm_src_unpack(){
	default_src_unpack

	# If we used the default SRC_URI for the npm registry, then the
	# tarball will extract into a single directory called
	# "package". Rather than mangle $S, we rename that directory here to
	# match what $S already expects.
	if [[ -d package && -f package/package.json ]]; then
		mv package "${P}" || die 'failed to rename "package" directory'
	fi
}
