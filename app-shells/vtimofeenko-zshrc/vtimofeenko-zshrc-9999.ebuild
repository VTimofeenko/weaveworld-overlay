# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="My zshrc"
HOMEPAGE="https://github.com/VTimofeenko/zsh-config"
KEYWORDS=""
EGIT_REPO_URI="https://github.com/VTimofeenko/zsh-config.git"

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

src_install() {
	insinto usr/share/zsh/site-contrib/"${PN}"
	for file in "${WORKDIR}"/*; do
		doins -r "${file}"
	done
}
