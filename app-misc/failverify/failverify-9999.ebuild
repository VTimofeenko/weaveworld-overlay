# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-verify-signature

DESCRIPTION="This is a test ebuild that will fail the verification"
HOMEPAGE="https://github.com/VTimofeenko/unsigned-repo-verify-signature"
SRC_URI=""
EGIT_REPO_URI="https://github.com/VTimofeenko/unsigned-repo-verify-signature"

VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/pubkey_id_vtimofeenko.asc

LICENSE="Unlicense"
SLOT="0"
KEYWORDS=""
IUSE="unsigned_commit unsigned_tag signed_commit signed_tag"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="verify-sig? ( app-crypt/openpgp-keys-vtimofeenko )"

pkg_setup() {
	local mycommit
	if use unsigned_commit; then
		mycommit="f571fe0d3bdf2da8d7e934f76190f41d11e879de"
	elif use signed_commit; then
		mycommit="d933ea2fc0ecd7c33d73371ae02bea310c0551ce"
	elif use unsigned_tag; then
		mycommit="unsigned_tag"
	elif use signed_tag; then
		mycommit="signed_tag"
	fi
	export EGIT_COMMIT=$mycommit
}
