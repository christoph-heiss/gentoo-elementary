# Copyright 20192-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson vala

DESCRIPTION="Cloudproviders integration API"
HOMEPAGE="https://gitlab.gnome.org/World/libcloudproviders"
SRC_URI="https://gitlab.gnome.org/World/libcloudproviders/-/archive/${PV}/libcloudproviders-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc +introspection +vala"
RESTRICT="mirror"

REQUIRED_USE="
	vala? ( introspection )
"
DEPEND="
	doc? ( dev-util/gdbus-codegen )
	virtual/pkgconfig
"
BDEPEND="${DEPEND}
	>=dev-libs/glib-2.51.2:2
	introspection? ( dev-libs/gobject-introspection:= )
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		$(meson_use introspection)
		$(meson_use vala vapigen)
		$(meson_use doc enable-gtk-doc)
	)
	meson_src_configure
}
