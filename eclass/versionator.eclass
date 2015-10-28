# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: versionator.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR: Andrey Ovcharov <sudormrfhalt@gmail.com> (09 Apr 2014)
# Original author: Jonathan Callen <jcallen@gentoo.org>
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: functions which simplify manipulation of ${PV} and similar version strings
# @DESCRIPTION:
# This eclass provides functions which simplify manipulating $PV and similar
# variables. Most functions default to working with $PV, although other
# values can be used.
# @EXAMPLE:
# Simple Example 1: $PV is 1.2.3b, we want 1_2.3b:
#     MY_PV=$(replace_version_separator 1 '_' )
#
# Simple Example 2: $PV is 1.4.5, we want 1:
#     MY_MAJORV=$(get_major_version )
#
# Rather than being a number, the index parameter can be a separator character
# such as '-', '.' or '_'. In this case, the first separator of this kind is
# selected.
#
# There's also:
#     version_is_at_least             want      have
#  which may be buggy, so use with caution.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/versionator.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

#case ${EAPI} in
#	5)	: ;;
#	*)	die "versionator.eclass: unsupported EAPI=${EAPI:-0}" ;;
#esac

if [[ ${___ECLASS_ONCE_VERSIONATOR} != "recur -_+^+_- spank" ]] ; then
___ECLASS_ONCE_VERSIONATOR="recur -_+^+_- spank"

inherit eutils

# @FUNCTION: get_all_version_components
# @USAGE: [version]
# @DESCRIPTION:
# Split up a version string into its component parts. If no parameter is
# supplied, defaults to $PV.
#     0.8.3       ->  0 . 8 . 3
#     7c          ->  7 c
#     3.0_p2      ->  3 . 0 _ p2
#     20040905    ->  20040905
#     3.0c-r1     ->  3 . 0 c - r1
get_all_version_components() {
	eshopts_push -s extglob
	local ver_str=${1:-${PV}} result
	result=()

	# sneaky cache trick cache to avoid having to parse the same thing several
	# times.
	if [[ ${VERSIONATOR_CACHE_VER_STR} == ${ver_str} ]] ; then
		echo ${VERSIONATOR_CACHE_RESULT}
		eshopts_pop
		return
	fi
	export VERSIONATOR_CACHE_VER_STR=${ver_str}

	while [[ -n $ver_str ]] ; do
		case "${ver_str::1}" in
			# number: parse whilst we have a number
			[[:digit:]])
				result+=("${ver_str%%[^[:digit:]]*}")
				ver_str=${ver_str##+([[:digit:]])}
				;;

			# separator: single character
			[-_.])
				result+=("${ver_str::1}")
				ver_str=${ver_str:1}
				;;

			# letter: grab the letters plus any following numbers
			[[:alpha:]])
				local not_match=${ver_str##+([[:alpha:]])*([[:digit:]])}
				# Can't say "${ver_str::-${#not_match}}" in Bash 3.2
				result+=("${ver_str::${#ver_str} - ${#not_match}}")
				ver_str=${not_match}
				;;

			# huh?
			*)
				result+=("${ver_str::1}")
				ver_str=${ver_str:1}
				;;
		esac
	done

	export VERSIONATOR_CACHE_RESULT=${result[*]}
	echo ${result[@]}
	eshopts_pop
}

# @FUNCTION: get_version_components
# @USAGE: [version]
# @DESCRIPTION:
# Get the important version components, excluding '.', '-' and '_'. Defaults to
# $PV if no parameter is supplied.
#     0.8.3       ->  0 8 3
#     7c          ->  7 c
#     3.0_p2      ->  3 0 p2
#     20040905    ->  20040905
#     3.0c-r1     ->  3 0 c r1
get_version_components() {
	local c=$(get_all_version_components "${1:-${PV}}")
	echo ${c//[-._]/ }
}

# @FUNCTION: get_major_version
# @USAGE: [version]
# @DESCRIPTION:
# Get the major version of a value. Defaults to $PV if no parameter is supplied.
#     0.8.3       ->  0
#     7c          ->  7
#     3.0_p2      ->  3
#     20040905    ->  20040905
#     3.0c-r1     ->  3
get_major_version() {
	local c=($(get_all_version_components "${1:-${PV}}"))
	echo ${c[0]}
}

# @FUNCTION: get_version_component_range
# @USAGE: <range> [version]
# @DESCRIPTION:
# Get a particular component or range of components from the version. If no
# version parameter is supplied, defaults to $PV.
#    1      1.2.3       -> 1
#    1-2    1.2.3       -> 1.2
#    2-     1.2.3       -> 2.3
get_version_component_range() {
	eshopts_push -s extglob
	local c v="${2:-${PV}}" range="${1}" range_start range_end
	local -i i=-1 j=0
	c=($(get_all_version_components "${v}"))
	range_start=${range%-*}; range_start=${range_start:-1}
	range_end=${range#*-}  ; range_end=${range_end:-${#c[@]}}

	while ((j < range_start)); do
		i+=1
		((i > ${#c[@]})) && eshopts_pop && return
		[[ -n "${c[i]//[-._]}" ]] && j+=1
	done

	while ((j <= range_end)); do
		echo -n ${c[i]}
		((i > ${#c[@]})) && eshopts_pop && return
		[[ -n "${c[i]//[-._]}" ]] && j+=1
		i+=1
	done
	eshopts_pop
}

# @FUNCTION: get_after_major_version
# @USAGE: [version]
# @DESCRIPTION:
# Get everything after the major version and its separator (if present) of a
# value. Defaults to $PV if no parameter is supplied.
#     0.8.3       ->  8.3
#     7c          ->  c
#     3.0_p2      ->  0_p2
#     20040905    ->  (empty string)
#     3.0c-r1     ->  0c-r1
get_after_major_version() {
	echo $(get_version_component_range 2- "${1:-${PV}}")
}

# @FUNCTION: replace_version_separator
# @USAGE: <search> <replacement> [subject]
# @DESCRIPTION:
# Replace the $1th separator with $2 in $3 (defaults to $PV if $3 is not
# supplied). If there are fewer than $1 separators, don't change anything.
#     1 '_' 1.2.3       -> 1_2.3
#     2 '_' 1.2.3       -> 1.2_3
#     1 '_' 1b-2.3      -> 1b_2.3
# Rather than being a number, $1 can be a separator character such as '-', '.'
# or '_'. In this case, the first separator of this kind is selected.
replace_version_separator() {
	eshopts_push -s extglob
	local w c v="${3:-${PV}}"
	declare -i i found=0
	w=${1:-1}
	c=($(get_all_version_components ${v}))
	if [[ ${w} != *[[:digit:]]* ]] ; then
		# it's a character, not an index
		for ((i = 0; i < ${#c[@]}; i++)); do
			if [[ ${c[i]} == ${w} ]]; then
				c[i]=${2}
				break
			fi
		done
	else
		for ((i = 0; i < ${#c[@]}; i++)); do
			if [[ -n "${c[i]//[^-._]}" ]]; then
				found+=1
				if ((found == w)); then
					c[i]=${2}
					break
				fi
			fi
		done
	fi
	c=${c[*]}
	echo ${c// }
	eshopts_pop
}

# @FUNCTION: replace_all_version_separators
# @USAGE: <replacement> [subject]
# @DESCRIPTION:
# Replace all version separators in $2 (defaults to $PV) with $1.
#     '_' 1b.2.3        -> 1b_2_3
replace_all_version_separators() {
	local c=($(get_all_version_components "${2:-${PV}}"))
	c=${c[@]//[-._]/$1}
	echo ${c// }
}

# @FUNCTION: delete_version_separator
# @USAGE: <search> [subject]
# @DESCRIPTION:
# Delete the $1th separator in $2 (defaults to $PV if $2 is not supplied). If
# there are fewer than $1 separators, don't change anything.
#     1 1.2.3       -> 12.3
#     2 1.2.3       -> 1.23
#     1 1b-2.3      -> 1b2.3
# Rather than being a number, $1 can be a separator character such as '-', '.'
# or '_'. In this case, the first separator of this kind is deleted.
delete_version_separator() {
	replace_version_separator "${1}" "" "${2}"
}

# @FUNCTION: delete_all_version_separators
# @USAGE: [subject]
# @DESCRIPTION:
# Delete all version separators in $1 (defaults to $PV).
#     1b.2.3        -> 1b23
delete_all_version_separators() {
	replace_all_version_separators "" "${1}"
}

# @FUNCTION: get_version_component_count
# @USAGE: [version]
# @DESCRIPTION:
# How many version components are there in $1 (defaults to $PV)?
#     1.0.1       ->  3
#     3.0c-r1     ->  4
get_version_component_count() {
	local a=($(get_version_components "${1:-${PV}}"))
	echo ${#a[@]}
}

# @FUNCTION: get_last_version_component_index
# @USAGE: [version]
# @DESCRIPTION:
# What is the index of the last version component in $1 (defaults to $PV)?
# Equivalent to get_version_component_count - 1.
#     1.0.1       ->  2
#     3.0c-r1     ->  3
get_last_version_component_index() {
	echo $(($(get_version_component_count "${1:-${PV}}" ) - 1))
}

# @FUNCTION: version_is_at_least
# @USAGE: <want> [have]
# @DESCRIPTION:
# Is $2 (defaults to $PVR) at least version $1? Intended for use in eclasses
# only. May not be reliable, be sure to do very careful testing before actually
# using this.
version_is_at_least() {
	local want_s="$1" have_s="${2:-${PVR}}" r
	version_compare "${want_s}" "${have_s}"
	r=$?
	case $r in
		1|2)
			return 0
			;;
		3)
			return 1
			;;
		*)
			die "versionator compare bug [atleast, ${want_s}, ${have_s}, ${r}]"
			;;
	esac
}

# @FUNCTION: version_compare
# @USAGE: <A> <B>
# @DESCRIPTION:
# Takes two parameters (A, B) which are versions. If A is an earlier version
# than B, returns 1. If A is identical to B, return 2. If A is later than B,
# return 3. You probably want version_is_at_least rather than this function.
# May not be very reliable. Test carefully before using this.
version_compare() {
	eshopts_push -s extglob
	local ver_a=${1} ver_b=${2} parts_a parts_b cur_idx_a=0 cur_idx_b=0
	parts_a=( $(get_all_version_components "${ver_a}" ) )
	parts_b=( $(get_all_version_components "${ver_b}" ) )

	### compare number parts.
	local inf_loop=0
	while true ; do
		# grab the current number components
		local cur_tok_a=${parts_a[${cur_idx_a}]}
		local cur_tok_b=${parts_b[${cur_idx_b}]}

		# number?
		if [[ -n ${cur_tok_a} ]] && [[ -z ${cur_tok_a//[[:digit:]]} ]] ; then
			cur_idx_a=$(( ${cur_idx_a} + 1 ))
			[[ ${parts_a[${cur_idx_a}]} == "." ]] \
				&& cur_idx_a=$(( ${cur_idx_a} + 1 ))
		else
		    cur_tok_a=""
		fi

		if [[ -n ${cur_tok_b} ]] && [[ -z ${cur_tok_b//[[:digit:]]} ]] ; then
			cur_idx_b=$(( ${cur_idx_b} + 1 ))
			[[ ${parts_b[${cur_idx_b}]} == "." ]] \
				&& cur_idx_b=$(( ${cur_idx_b} + 1 ))
		else
			cur_tok_b=""
		fi

		# done with number components?
		[[ -z ${cur_tok_a} ]] && [[ -z ${cur_tok_b} ]] && break

		# to avoid going into octal mode, strip any leading zeros. otherwise
		# bash will throw a hissy fit on versions like 6.3.068.
		cur_tok_a=${cur_tok_a##+(0)}
		cur_tok_b=${cur_tok_b##+(0)}

		# if a component is blank, make it zero.
		[[ -z ${cur_tok_a} ]] && cur_tok_a=0
		[[ -z ${cur_tok_b} ]] && cur_tok_b=0

		# compare
		[[ ${cur_tok_a} -lt ${cur_tok_b} ]] && return 1
		[[ ${cur_tok_a} -gt ${cur_tok_b} ]] && return 3
	done

	### number parts equal. compare letter parts.
	local letter_a=
	letter_a=${parts_a[${cur_idx_a}]}
	if [[ ${#letter_a} -eq 1 ]] && [[ -z ${letter_a/[a-z]} ]] ; then
		cur_idx_a=$(( ${cur_idx_a} + 1 ))
	else
		letter_a="@"
	fi

	local letter_b=
	letter_b=${parts_b[${cur_idx_b}]}
	if [[ ${#letter_b} -eq 1 ]] && [[ -z ${letter_b/[a-z]} ]] ; then
		cur_idx_b=$(( ${cur_idx_b} + 1 ))
	else
		letter_b="@"
	fi

	# compare
	[[ ${letter_a} < ${letter_b} ]] && return 1
	[[ ${letter_a} > ${letter_b} ]] && return 3

	### letter parts equal. compare suffixes in order.
	local suffix rule part r_lt r_gt
	for rule in "alpha=1" "beta=1" "pre=1" "rc=1" "p=3" "r=3" ; do
		suffix=${rule%%=*}
		r_lt=${rule##*=}
		[[ ${r_lt} -eq 1 ]] && r_gt=3 || r_gt=1

		local suffix_a=
		for part in ${parts_a[@]} ; do
			[[ ${part#${suffix}} != ${part} ]] && \
				[[ -z ${part##${suffix}*([[:digit:]])} ]] && \
				suffix_a=${part#${suffix}}0
		done

		local suffix_b=
		for part in ${parts_b[@]} ; do
			[[ ${part#${suffix}} != ${part} ]] && \
				[[ -z ${part##${suffix}*([[:digit:]])} ]] && \
				suffix_b=${part#${suffix}}0
		done

		[[ -z ${suffix_a} ]] && [[ -z ${suffix_b} ]] && continue

		[[ -z ${suffix_a} ]] && return ${r_gt}
		[[ -z ${suffix_b} ]] && return ${r_lt}

		# avoid octal problems
		suffix_a=${suffix_a##+(0)} ; suffix_a=${suffix_a:-0}
		suffix_b=${suffix_b##+(0)} ; suffix_b=${suffix_b:-0}

		[[ ${suffix_a} -lt ${suffix_b} ]] && return 1
		[[ ${suffix_a} -gt ${suffix_b} ]] && return 3
	done

	### no differences.
	return 2
	eshopts_pop
}

# @FUNCTION: version_sort
# @USAGE: <version> [more versions...]
# @DESCRIPTION:
# Returns its parameters sorted, highest version last. We're using a quadratic
# algorithm for simplicity, so don't call it with more than a few dozen items.
# Uses version_compare, so be careful.
version_sort() {
	eshopts_push -s extglob
	local items= left=0
	items=( $@ )

	while [[ ${left} -lt ${#items[@]} ]] ; do
		local lowest_idx=${left}
		local idx=$(( ${lowest_idx} + 1 ))
		while [[ ${idx} -lt ${#items[@]} ]] ; do
			version_compare "${items[${lowest_idx}]}" "${items[${idx}]}"
			[[ $? -eq 3 ]] && lowest_idx=${idx}
			idx=$(( ${idx} + 1 ))
		done
		local tmp=${items[${lowest_idx}]}
		items[${lowest_idx}]=${items[${left}]}
		items[${left}]=${tmp}
		left=$(( ${left} + 1 ))
	done
	echo ${items[@]}
	eshopts_pop
}

# @FUNCTION: version_format_string
# @USAGE: <format> [version]
# @DESCRIPTION:
# Reformat complicated version strings.  The first argument is the string
# to reformat with while the rest of the args are passed on to the
# get_version_components function.  You should make sure to single quote
# the first argument since it'll have variables that get delayed expansions.
# @EXAMPLE:
# P="cow-hat-1.2.3_p4"
# MY_P=$(version_format_string '${PN}_source_$1_$2-$3_$4')
# Now MY_P will be: cow-hat_source_1_2-3_p4
version_format_string() {
	local fstr=$1
	shift
	set -- $(get_version_components "$@")
	eval echo "${fstr}"
}

fi
