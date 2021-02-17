# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.44

inherit git-r3 meson vala xdg-utils gnome2-utils

DESCRIPTION="An elementary fork of Plank, the stupidly-simple dock."
HOMEPAGE="https://github.com/elementary/dock"
EGIT_REPO_URI="https://github.com/elementary/dock.git"
EGIT_COMMIT="74ca7e505a0f864e3cdcfa9b992ef4069ac65456"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test +vala"
RESTRICT="!test? ( test )"


DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="
	app-accessibility/at-spi2-core
	dev-libs/libdbusmenu[gtk3]
	gnome-base/gnome-common
	>=x11-libs/bamf-0.3.0
	>=x11-libs/cairo-1.10
	>=x11-libs/gdk-pixbuf-2.26.0
	dev-libs/libgee:0.8
	dev-libs/glib:2
	>=gnome-base/gnome-menus-3.32.0
	>=x11-libs/gtk+-3.10.0:3
	x11-libs/libwnck:3
	x11-libs/libX11
	dev-libs/libxml2
	test? ( x11-misc/xvfb-run )
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		$(meson_use doc enable-docs)
		$(meson_use test enable-headless-tests)
	)
	meson_src_configure
}

src_test() {
	virtx meson_src_test
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
