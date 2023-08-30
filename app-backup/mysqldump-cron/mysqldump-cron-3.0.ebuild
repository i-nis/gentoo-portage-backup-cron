# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8


DESCRIPTION="Backup for MySQL."
HOMEPAGE="https://proyectos.nis.com.ar/projects/backup-cron"
SRC_URI="https://github.com/i-nis/backup-cron/archive/v${PV}.zip -> backup-cron-${PV}.zip"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-admin/tmpwatch
	>=virtual/backup-cron-3.0
	virtual/mysql"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/backup-cron-${PV}" "${WORKDIR}/${P}" || die "Install failed!"
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
