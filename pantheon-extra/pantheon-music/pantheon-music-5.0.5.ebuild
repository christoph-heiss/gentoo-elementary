# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.22

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Music player and library designed for elementary OS"
HOMEPAGE="https://github.com/elementary/music"
SRC_URI="https://github.com/elementary/music/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc ipod lastfm"
RESTRICT="mirror"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	lastfm? (
		dev-libs/json-glib
		net-libs/libaccounts-glib
		>=net-libs/libsignon-2.0
		net-libs/libsoup:2.4
	)
	ipod? ( media-libs/libgpod )
	dev-libs/dbus-glib
	>=dev-libs/glib-2.39:2
	>=dev-libs/granite-5.2.0
	dev-libs/libgee:0.8
	dev-libs/libpeas[gtk]
	dev-libs/libxml2
	>=gnome-extra/libgda-5.2.9:5[vala]
	gnome-extra/zeitgeist
	>=gui-libs/libhandy-0.83.0:1[vala]
	media-libs/clutter-gtk
	media-libs/gst-plugins-base
	media-libs/gstreamer
	media-libs/taglib
	media-plugins/gst-plugins-meta[mp3]
	>=x11-libs/gtk+-3.22:3
	x11-libs/libnotify
"

S="${WORKDIR}/music-${PV}"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	local plugs="[ 'audioplayer'"
	use ipod && plugs="$plugs, 'ipod'"
	use lastfm && plugs="$plugs, 'lastfm'"
	plugs="$plugs ]"

	local emesonargs=(
		-Dbuild-plugins=true
		-Dplugins="$plugs"
		$(meson_use doc documentation)
	)
	meson_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
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
