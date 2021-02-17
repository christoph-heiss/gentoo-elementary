# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.28

inherit meson vala virtualx xdg

DESCRIPTION="Building blocks for modern adaptive GNOME apps"
HOMEPAGE="https://gitlab.gnome.org/GNOME"
SRC_URI="https://gitlab.gnome.org/GNOME/libhandy/-/archive/${PV}/libhandy-${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="LGPL-2.1+"
SLOT="1"
IUSE="examples glade gtk-doc +introspection test +vala"
RESTRICT="mirror !test? ( test )"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	>=x11-libs/gtk+-3.24.1[introspection?]
	glade? ( dev-util/glade:3.10/12 )
	introspection? ( >=dev-libs/gobject-introspection-1.54:= )
"

src_prepare() {
	use vala && vala_src_prepare
	xdg_src_prepare
}

src_configure() {
	local emesonargs=(
		$(meson_feature introspection)
		$(meson_use vala vapi)
		$(meson_use gtk-doc gtk_doc)
		$(meson_use test tests)
		$(meson_use examples)
		$(meson_feature glade glade_catalog)
	)
	meson_src_configure
}

src_test() {
	virtx meson_src_test
}
