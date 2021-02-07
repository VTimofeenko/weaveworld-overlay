# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Public key of Vladimir Timofeenko"
HOMEPAGE="https://vtimofeenko.github.io"
SRC_URI="https://raw.githubusercontent.com/VTimofeenko/vtimofeenko.github.io/3ecf0d687fa4cbb13c9c9402d8bed18c4f718468/assets/pubkey_id_vtimofeenko.asc"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/pubkey_id_vtimofeenko.asc" "${S}"
}

src_install() {
	insinto /usr/share/openpgp-keys/
	doins pubkey_id_vtimofeenko.asc
}
