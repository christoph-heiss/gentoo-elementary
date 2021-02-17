# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Collection of wallpapers for elementary OS"
HOMEPAGE="https://github.com/elementary/wallpapers"
SRC_URI="https://github.com/elementary/wallpapers/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND=""

S=${WORKDIR}/wallpapers-${PV}
