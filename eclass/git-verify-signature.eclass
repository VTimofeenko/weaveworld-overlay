# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: git-verify-signature.eclass
# @MAINTAINER:
# Vladimir Timofeenko <overlay.maintain@vtimofeenko.com>
# @AUTHOR:
# Vladimir Timofeenko <overlay.maintain@vtimofeenko.com>
# @BLURB: Allows verifying signature on top commit
# @DESCRIPTION:
# Detaches the signature from top commit and verifies it
# using verify-sig.eclass utilities

EXPORT_FUNCTIONS src_unpack

inherit verify-sig git-r3

# @FUNCTION: git-verify-signature_src_unpack
# @DESCRIPTION:
# Forces usage of src_unpack from git-r3, which is usually
# what I want
git-verify-signature_src_unpack() {
	git-r3_src_unpack
}

# @FUNCTION: git-verify-signature_verify-commit
# @DESCRIPTION:
# Parse the git signature from top commit
# and verify it using the keys from verify-sig
# should be called in src_prepare
git-verify-signature_verify-commit() {
	local git_signature commit_msg_file signature_file commit_first_part commit_last_part

	git_signature=$(git --work-tree="${S}" --git-dir "${S}"/.git cat-file -p HEAD)

	# extract signature
	signature_file="${T}"/commit_file.asc
	echo -e "$git_signature" | sed -n -e '/BEGIN PGP/,/END PGP/p' | sed 's/^gpgsig//' | sed 's/^ //g' > "$signature_file" \
		|| die 'Could not extract signature from HEAD'
	elog "Signature extracted to $signature_file"

	# extract commit message
	# should have the same name as signature, gpg relies on that
	commit_msg_file="${T}"/commit_file

	commit_first_part=$(echo -e "$git_signature" | sed -n -e '/gpgsig/,$!p') || die "Could not extract part before signature"
	# -n needed for removing extra newline
	commit_last_part=$(echo -n -e "$git_signature" | sed -n -e '1,/END PGP/!p') || die "Could not extract last part"

	echo -e "${commit_first_part}\n${commit_last_part}" > "${commit_msg_file}"
	elog "Commit message extracted to ${commit_msg_file}"

	verify-sig_verify_message "$signature_file" /dev/null
}

