# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.28

inherit git-r3 meson vala xdg-utils gnome2-utils

DESCRIPTION="Settings Daemon for elementary OS"
HOMEPAGE="https://github.com/elementary/settings-daemon"
EGIT_REPO_URI="https://github.com/elementary/settings-daemon.git"
EGIT_COMMIT="cb540d21b9eec0788edbe7f3c716660cf21cc33f"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
"
RDEPEND="
	dev-libs/glib:2
	dev-libs/granite
	sci-geosciences/geocode-glib
	sys-apps/accountsservice
	sys-apps/dbus
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_schemas_update
}
