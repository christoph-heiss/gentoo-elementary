# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.28

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Calculator app designed for elementary OS"
HOMEPAGE="https://github.com/elementary/calculator"
SRC_URI="https://github.com/elementary/calculator/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE="test"

RDEPEND="
	dev-libs/appstream
	dev-libs/glib:2
	>=dev-libs/granite-0.5.0
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

S=${WORKDIR}/calculator-${PV}

src_prepare() {
	eapply "${FILESDIR}/${PV}-add_test_option.patch"
	eapply_user

	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dtest=$(usex test true false)
	)
	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
