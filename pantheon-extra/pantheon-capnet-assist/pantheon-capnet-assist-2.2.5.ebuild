# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.28

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Captive Portal Assistant for elementary OS."
HOMEPAGE="https://github.com/elementary/capnet-assist"
SRC_URI="https://github.com/elementary/capnet-assist/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	app-crypt/gcr[vala]
	dev-libs/glib:2
	dev-libs/granite
	net-libs/webkit-gtk
	x11-libs/gtk+:3
"

DEPEND="${RDEPEND}
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

S=${WORKDIR}/capnet-assist-${PV}

src_prepare() {
	eapply_user

	vala_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_icon_cache_update
	gnome2_schemas_update
}
