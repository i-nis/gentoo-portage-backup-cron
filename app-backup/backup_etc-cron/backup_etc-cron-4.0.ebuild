# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Backup for system configuration files in /etc"
HOMEPAGE="https://gitlab.nis.com.ar/proyectos/backup-cron"
SRC_URI="https://gitlab.nis.com.ar/proyectos/backup-cron/-/archive/v${PV}/backup-cron-v${PV}.tar.bz2 -> backup-cron-${PV}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-admin/tmpwatch >=app-backup/backup-cron-4.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/backup-cron-v${PV}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	dodir /etc/cron.daily
	dodir /etc/cron.monthly/
	cp -pR "${S}"/etc/cron.monthly/00_backup_etc "${D}"/etc/cron.monthly
	fperms 700 /etc/cron.daily/00_backup_etc
	dosbin "${S}"/usr/sbin/backup_etc
	dosym ../../usr/sbin/backup_etc /etc/cron.daily/backup_etc
}
