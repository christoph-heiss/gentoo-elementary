# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.44

inherit meson vala xdg-utils

DESCRIPTION="A native, OS-wide shortcut overlay"
HOMEPAGE="https://github.com/elementary/shortcut-overlay"
SRC_URI="https://github.com/elementary/shortcut-overlay/archive/${PV}.tar.gz -> ${P}.tar.gz"

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
	>=dev-libs/granite-5.4.0
	dev-libs/libgee:0.8
	x11-libs/gtk+:3
"

S="${WORKDIR}/shortcut-overlay-${PV}"

src_prepare() {
	eapply_user
	vala_src_prepare
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
