# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.28

inherit git-r3 gnome2-utils meson vala xdg-utils

DESCRIPTION="A system settings panel for the Pantheon desktop environment"
HOMEPAGE="https://github.com/pantheon-tweaks"
EGIT_REPO_URI="https://github.com/pantheon-tweaks/pantheon-tweaks.git"
EGIT_COMMIT="0f748f130c09c46cc4c6278b6cb3b80ec4ac770a"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite
	gnome-base/gconf:2
	pantheon-base/switchboard
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
