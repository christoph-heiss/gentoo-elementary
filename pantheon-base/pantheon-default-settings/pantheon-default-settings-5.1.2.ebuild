# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson

DESCRIPTION="Default settings for elementary OS"
HOMEPAGE="https://github.com/elementary/default-settings"
SRC_URI="https://github.com/elementary/default-settings/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	media-fonts/open-sans
	media-fonts/roboto
	x11-themes/elementary-icons-theme
	x11-themes/elementary-sound-theme
	x11-themes/elementary-theme
	x11-themes/elementary-wallpapers
"

S="${WORKDIR}/default-settings-${PV}"

src_prepare() {
	eapply "${FILESDIR}/${PV}-build_with_meson.patch"
	eapply "${FILESDIR}/${PV}-use_systemd_symlink_script.patch"
	eapply "${FILESDIR}/${PV}-remove_cups_default_testpage.patch"
	eapply_user
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
