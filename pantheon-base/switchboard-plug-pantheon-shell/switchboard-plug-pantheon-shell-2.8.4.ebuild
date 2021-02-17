# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.20

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Switchboard Desktop Plug"
HOMEPAGE="https://github.com/elementary/switchboard-plug-pantheon-shell"
SRC_URI="https://github.com/elementary/switchboard-plug-pantheon-shell/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite
	media-libs/gexiv2[vala]
	gnome-base/gnome-desktop:=
	pantheon-base/pantheon-dock
	pantheon-base/switchboard
	pantheon-extra/contractor
	>=x11-libs/gtk+-3.22:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_schemas_update
}
