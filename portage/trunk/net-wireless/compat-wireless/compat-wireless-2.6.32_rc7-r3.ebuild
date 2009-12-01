# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit linux-mod linux-info

##Stable
MY_P=${P/_rc/-rc}
DESCRIPTION="Stable kernel pre-release wifi subsystem backport"
HOMEPAGE="http://wireless.kernel.org/en/users/Download/stable"
SRC_URI="http://www.orbit-lab.org/kernel/${PN}-2.6-stable/v2.6.32/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="injection"

DEPEND=""
RDEPEND="=sys-kernel/linux-firmware-99999999"

S=${WORKDIR}/${MY_P}
RESTRICT="strip"

CONFIG_CHECK="!DYNAMIC_FTRACE"

pkg_setup() {
	linux-mod_pkg_setup
	kernel_is -lt 2 6 27 && die "kernel 2.6.27 or higher is required"
	linux_chkconfig_module MAC80211 || die "CONFIG_MAC80211 must be built as a _module_ !"
	linux_chkconfig_module CFG80211 || die "CONFIG_CFG80211 must be built as a _module_ !"
}

src_prepare() {
	#whynot patch is against the makefile to fix general brokeness
	epatch "${FILESDIR}"/whynot-2.6.32.patch
	epatch "${FILESDIR}"/4099-2.6.32-rc7-mac80211-security-fixes.patch

	if use injection; then
		epatch "${FILESDIR}"/400[24]_*.patch
		epatch "${FILESDIR}"/mac80211.compat08082009.wl_frag+ack_v1.patch
		epatch "${FILESDIR}"/4013-runtime-enable-disable-of-mac80211-packet-injection.patch
		epatch "${FILESDIR}"/compat-chaos.patch;
	fi
}

src_compile() {
	addpredict "${KERNEL_DIR}"
	set_arch_to_kernel
	emake KVER="${KV_FULL}" || die "emake failed"
}

src_install() {
	for file in $(find -name \*.ko); do
		insinto "/lib/modules/${KV_FULL}/updates/$(dirname ${file})"
		doins "${file}" || die "failed to install module ${file}"
	done
	dosbin scripts/athenable scripts/b43load scripts/iwl-enable \
		scripts/madwifi-unload scripts/athload scripts/iwl-load \
		scripts/modlib.sh scripts/b43enable scripts/load.sh \
		scripts/unload.sh || die "script installation failed"
	dodoc README || die
}

pkg_postinst() {
	update_depmod
	einfo 'You may have problem if you do not run "depmod -ae" after this installation'
	einfo 'To switch to the new drivers without reboot run unload.sh then load.sh'
}
