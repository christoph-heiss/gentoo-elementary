# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.28

inherit git-r3 gnome2-utils meson vala xdg-utils

DESCRIPTION="Synced tasks and reminders on elementary OS"
HOMEPAGE="https://github.com/elementary"
EGIT_REPO_URI="https://github.com/elementary/tasks.git"
EGIT_COMMIT="ebc91325082674cf17377b8bf2d27cd454680225"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	>=dev-libs/granite-0.5.0
	dev-libs/libgdata
	dev-libs/libical[glib,vala]
	gnome-extra/evolution-data-server[vala]
	>=gui-libs/libhandy-0.90.0:1[vala]
  media-libs/libchamplain:0.12[gtk,vala]
	sci-geosciences/geocode-glib
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
