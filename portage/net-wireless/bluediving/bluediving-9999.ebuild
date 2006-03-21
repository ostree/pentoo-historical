# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-wireless/bluediving/bluediving-9999.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

inherit eutils

DESCRIPTION="A utility for bluetooth scanning and discovery"
HOMEPAGE="http://www.pentest.co.uk/cgi-bin/viewcat.cgi?cat=downloads"
SRC_URI="http://www.pentest.co.uk/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-wireless/bluez-utils-2.15
	>=net-wireless/bluez-libs-2.15
	>=dev-libs/libbtctl-0.5.0
	dev-perl/XML-Simple"

src_compile() {
	
}
src_install() {
	einstall || die "install failed"
	dodoc AUTHORS ChangeLog README NEWS TODO USAGE
}
