# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/upnpscan/upnpscan-0.4.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $


DESCRIPTION="Scans the network for UPNP capable devices"
HOMEPAGE="http://www.cqure.net/tools.jsp?id=23"
SRC_URI="http://www.cqure.net/tools/${PN}-v${PV}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="static"

DEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	if use static
	then
		./configure || die
	else
		./configure --enable-static=no || die
	fi
}

src_install () {

	einstall || die

}
