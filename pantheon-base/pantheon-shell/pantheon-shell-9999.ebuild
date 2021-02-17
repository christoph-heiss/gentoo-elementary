# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="Session settings for elementary OS"
HOMEPAGE="https://github.com/elementary/session-settings"
EGIT_REPO_URI="https://github.com/elementary/session-settings.git"
EGIT_COMMIT="f52f9b009961c5245d282801224f9eff81c9403e"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-accessibility smartcard input_devices_wacom"

# accessibility is currently broken as app-accessibility is not yet
# packaged for gentoo
DEPEND=""
RDEPEND="${DEPEND}
	accessibility? (
		app-accessibility/onboard
		app-accessibility/orca
	)
	gnome-base/gnome-session
	gnome-base/gnome-settings-daemon
	pantheon-base/applications-menu
	pantheon-base/pantheon-dock
	pantheon-base/wingpanel
	pantheon-extra/dpms-helper
	pantheon-extra/pantheon-agent-polkit
	x11-wm/gala
"
PDEPEND="
	pantheon-base/pantheon-default-settings
"

src_prepare() {
	eapply_user

	use accessibility || \
		eapply "${FILESDIR}/${PV}-remove_accessibility_autostarts.patch"

	use smartcard || \
		eapply "${FILESDIR}/${PV}-remove_smartcard_component.patch"

	use input_devices_wacom || \
		eapply "${FILESDIR}/${PV}-remove_wacom_component.patch"
}
