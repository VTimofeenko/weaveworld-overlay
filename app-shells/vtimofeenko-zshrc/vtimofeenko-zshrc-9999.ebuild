# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="My zshrc"
HOMEPAGE="https://github.com/VTimofeenko/zsh-config"
KEYWORDS=""
EGIT_REPO_URI="https://github.com/VTimofeenko/zsh-config.git"
EGIT_SUBMODULES=()

LICENSE="Unlicense"
SLOT="0"
IUSE=""

DEPEND="
>=app-shells/zsh-5.0
app-shells/zsh-autosuggestions
app-shells/zsh-async
app-shells/fzf
app-shells/zsh-syntax-highlighting
app-shells/zsh-completions
"
RDEPEND="${DEPEND}"
BDEPEND=""

MY_INSTALL_DIR="${EPREFIX}/usr/share/zsh/site-contrib/${PN}"

src_prepare() {
	default
	for config in zshenv_skel zprofile_skel; do
		sed -i "s#export ZSH_CONFIG_SHARED_REPO=\"REPLACEME\"#export ZSH_CONFIG_SHARED_REPO=\"${MY_INSTALL_DIR}\"#" "${S}"/configs/skeletons/"$config"
		elog "Sedded ${config}"
	done
}
src_install() {
	insinto "${MY_INSTALL_DIR}"
	doins -r "${S}"/*
}

pkg_postinst() {
	elog "The zshrc has been installed into "
	elog "/${MY_INSTALL_DIR}"
	elog "To use it, add"
	elog "export ZSH_CONFIG_SHARED_REPO=\"/${MY_INSTALL_DIR}\""
	elog "to zshrc (and maybe zprofile)"
	elog "Alternatively, use the skeleton files from repo"
}
