# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-verify-signature

DESCRIPTION="My nvim config"
HOMEPAGE="https://git.home.local/VT/nvim-config"
SRC_URI=""
EGIT_REPO_URI="https://git.home.local/VT/nvim-config"
VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/pubkey_id_vtimofeenko.asc

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="verify-sig? ( app-crypt/openpgp-keys-vtimofeenko )"

MY_INSTALL_DIR="${EPREFIX}/usr/share/nvim/vtimofeenko_nvimrc"

src_install() {
	dodir "${MY_INSTALL_DIR}"
	insinto "${MY_INSTALL_DIR}"
	doins -r "${S}"/*
}

pkg_postinst(){
	einfo "export VT_NVIM_CONFIG_LOCATION=\"${MY_INSTALL_DIR}\""
}
