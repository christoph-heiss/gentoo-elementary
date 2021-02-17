# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson xdg-utils

DESCRIPTION="Named, vector icons for elementary OS"
HOMEPAGE="https://github.com/elementary/icons"
SRC_URI="https://github.com/elementary/icons/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror"

DEPEND="
	gnome-base/librsvg
	x11-apps/xcursorgen
"
RDEPEND=""

S=${WORKDIR}/icons-${PV}

src_configure() {
	local emesonargs=(
		-Dvolume_icons=false
		-Dpalettes=false
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
