# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Backup on DAT and LTO tapes."
HOMEPAGE="https://proyectos.nis.com.ar/projects/backup-cron"
SRC_URI="https://github.com/i-nis/backup-cron/archive/v${PV}.tar.gz -> backup-cron-${PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-admin/tmpwatch
	>=app-backup/backup-cron-3.0
	app-arch/mt-st
	sys-block/mbuffer"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/backup-cron-${PV}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/backup_tape.cron
	dosym ../../usr/sbin/backup_tape.cron /etc/cron.daily/backup_tape.cron
}
