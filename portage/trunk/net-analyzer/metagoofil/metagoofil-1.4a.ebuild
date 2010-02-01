# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Metagoofil is an information gathering tool designed for extracting metadata of public documents"
HOMEPAGE="http://www.edge-security.com/metagoofil.php"
SRC_URI="http://www.edge-security.com/soft/${P}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="media-libs/libextractor"

src_configure() {

	# Add the following line, so metagoofil.py can be executed directly.
	sed -i '1i#!\/usr\/bin\/python' "${PN}".py \
		|| die 'sed failed'

	# change libextractor default location
	sed -i -e "s:/opt/local/bin/extract:/usr/bin/extract:g"	"${PN}".py
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dobin "${PN}".py
	dodoc README
}
