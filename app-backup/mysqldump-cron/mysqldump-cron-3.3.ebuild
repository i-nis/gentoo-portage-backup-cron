# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Backup for MySQL."
HOMEPAGE="https://gitlab.nis.com.ar/proyectos/backup-cron"
SRC_URI="https://gitlab.nis.com.ar/proyectos/backup-cron/-/archive/v${PV}/backup-cron-v${PV}.tar.bz2 -> backup-cron-${PV}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-admin/tmpwatch
	>=app-backup/backup-cron-3.2
	virtual/mysql"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/backup-cron-v${PV}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/mysqldump.cron
	dosbin "${S}"/usr/sbin/mysql_restore
	dosym ../../usr/sbin/mysqldump.cron /etc/cron.daily/mysqldump.cron
}

pkg_postinst() {
	local file="${EROOT}/etc/backup-cron/backup-cron.conf"
	einfo "Don't forget set root password in BDB_PASSWD parameter at '${file}' script."
}
