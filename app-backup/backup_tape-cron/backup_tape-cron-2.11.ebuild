# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit git-2

DESCRIPTION="Backup on DAT and LTO tapes."
HOMEPAGE="https://proyectos.ingeniovirtual.com.ar/projects/backup-cron"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingeniovirtual/backup-cron.git"
EGIT_COMMIT="v${PV}"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-admin/tmpwatch
	app-arch/mt-st
	>=sys-process/vixie-cron-4
	>=virtual/backup-cron-2.11"
RDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack
}

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/backup_tape.cron

	if [ ! -h /etc/cron.*/backup_tape.cron ]; then
			dosym /usr/sbin/backup_tape.cron /etc/cron.daily/backup_tape.cron
		else
			dosym /usr/sbin/backup_tape.cron $(ls /etc/cron.*/backup_tape.cron)
	fi
}
