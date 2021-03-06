# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.28

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Desktop calendar app designed for elementary OS"
HOMEPAGE="https://github.com/elementary/calendar"
SRC_URI="https://github.com/elementary/calendar/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

# gnome-extra/evolution-data-server is needed for libecal
RDEPEND="${DEPEND}
	dev-libs/folks
	dev-libs/glib:2
	>=dev-libs/granite-5.2.0
	dev-libs/libgee:0.8
	dev-libs/libical[glib,vala]
	gnome-extra/evolution-data-server[vala]
	media-libs/clutter:1.0
	media-libs/clutter-gtk:1.0
	media-libs/libchamplain:0.12[gtk]
	net-libs/libsoup:2.4
	sci-geosciences/geocode-glib
	>=x11-libs/gtk+-3.22:3
"

S="${WORKDIR}/calendar-${PV}"

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
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}
