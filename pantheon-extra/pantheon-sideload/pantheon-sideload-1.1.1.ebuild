# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.44

inherit meson vala xdg-utils

DESCRIPTION="Sideload Flatpaks on elementary OS"
HOMEPAGE="https://github.com/elementary/sideload"
SRC_URI="https://github.com/elementary/sideload/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-5.4.0
	dev-libs/libxml2
	>=sys-apps/flatpak-1.1.2
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

S=${WORKDIR}/sideload-${PV}

src_prepare() {
	eapply_user
	vala_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
