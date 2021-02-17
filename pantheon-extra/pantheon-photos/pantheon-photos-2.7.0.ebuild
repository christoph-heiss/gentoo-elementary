# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.40

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Photo viewer and organizer designed for elementary OS"
HOMEPAGE="https://github.com/elementary/photos"
SRC_URI="https://github.com/elementary/photos/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"
RESTRICT="mirror"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	>=dev-db/sqlite-3.5.9:3
	>=dev-libs/glib-2.30:2
	dev-libs/granite
	dev-libs/json-glib
	dev-libs/libgudev
	>=dev-libs/libgee-0.8.5:0.8
	>=dev-libs/libxml2-2.6.32:2[python]
	>=media-libs/gexiv2-0.4.90
	>=media-libs/gstreamer-1.0.0:1.0
	>=media-libs/gst-plugins-base-1.0.0:1.0
	>=media-libs/libexif-0.6.16
	>=media-libs/libgphoto2-2.4.2
	>=media-libs/libraw-0.13.2
	>=media-libs/libwebp-0.4.4
	>=net-libs/libsoup-2.26:2.4
	>=net-libs/rest-0.7:0.7
	>=net-libs/webkit-gtk-2.0.0:4
	sci-geosciences/geocode-glib
	>=x11-libs/gtk+-3.6.0:3
"

S="${WORKDIR}/photos-${PV}"

src_prepare() {
	eapply_user
	eapply "${FILESDIR}/${PV}-use_granite_instead_of_libunity.patch"

	vala_src_prepare
}

src_configure() {
	local emesonargs=(
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

