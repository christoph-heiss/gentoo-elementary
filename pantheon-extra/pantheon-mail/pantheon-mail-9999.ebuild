# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.22

inherit git-r3 gnome2-utils meson vala xdg-utils

DESCRIPTION="Mail app designed for elementary OS"
HOMEPAGE="https://github.com/elementary/mail"
# SRC_URI="https://github.com/elementary/mail/archive/${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/elementary/mail.git"
EGIT_COMMIT="1ae40d606cc1abaacb4dd4fbad508204c0b86a1e"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"
RESTRICT="mirror"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${RDEPEND}
	dev-libs/folks
	dev-libs/glib:2
	>=dev-libs/granite-5.2.0
	dev-libs/libgee:0.8
	>=gui-libs/libhandy-0.83.0:1[vala]
	>=gnome-extra/evolution-data-server-3.28
	>=net-libs/webkit-gtk-2.28
	x11-libs/gtk+:3
"

# S="${WORKDIR}/mail-${PV}"

src_prepare() {
	eapply_user
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
