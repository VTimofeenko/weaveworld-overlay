# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: git-verify-signature.eclass
# @MAINTAINER:
# Vladimir Timofeenko <overlay.maintain@vtimofeenko.com>
# @AUTHOR:
# Vladimir Timofeenko <overlay.maintain@vtimofeenko.com>
# @BLURB: Allows verifying signature on top commit
# @DESCRIPTION:
# Implements a default src_unpack that verifies the checked out commit
# Using VERIFY_SIG_OPENPGP_KEY_PATH

EXPORT_FUNCTIONS src_unpack

inherit git-r3 verify-sig

# @FUNCTION: git-verify-signature_src_unpack
# @DESCRIPTION:
git-verify-signature_src_unpack() {
	git-r3_src_unpack
	# if use verify-sig then verify
	if use verify-sig; then
		git-verify-signature_verify-commit "${EGIT_CHECKOUT_DIR:-${WORKDIR}/${P}}"
	fi
}

# @FUNCTION: git-verify-signature_verify-commit
# @USAGE: <git-directory>
# @DESCRIPTION:
# Verifies the HEAD commit in the supplied directory

git-verify-signature_verify-commit() {
	local git_dir=${1}
	gemato gpg-wrap -K "${VERIFY_SIG_OPENPGP_KEY_PATH}" -R -- \
		git --work-tree="${git_dir}" --git-dir="${git_dir}"/.git verify-commit HEAD ||
		die "Git commit verification failed"
}
