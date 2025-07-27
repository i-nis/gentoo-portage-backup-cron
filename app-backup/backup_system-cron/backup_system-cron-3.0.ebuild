# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Backup for all files in the system."
HOMEPAGE="https://gitlab.nis.com.ar/proyectos/backup-cron"
SRC_URI="https://gitlab.nis.com.ar/proyectos/backup-cron/-/archive/v${PV}/backup-cron-v${PV}.tar.bz2 -> backup-cron-${PV}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="no-home no-system usr-only var-only"
DEPEND="app-admin/tmpwatch >=app-backup/backup-cron-3.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/backup-cron-v${PV}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	dodir /etc/cron.daily

	# USE conditional blocks...
	if use no-home ; then
		dosbin "${S}"/usr/sbin/backup_raiz.cron
		dosym ../../usr/sbin/backup_raiz.cron /etc/cron.daily/backup_raiz.cron
	elif use no-system ; then
		dosbin "${S}"/usr/sbin/backup_home.cron
		dosym ../../usr/sbin/backup_home.cron /etc/cron.daily/backup_home.cron
	elif use usr-only ; then
		dosbin "${S}"/usr/sbin/backup_usr.cron
		dosym ../../usr/sbin/backup_usr.cron /etc/cron.daily/backup_usr.cron
	elif use var-only ; then
		dosbin "${S}"/usr/sbin/backup_var.cron
		dosym ../../usr/sbin/backup_var.cron /etc/cron.daily/backup_var.cron
	else
		dosbin "${S}"/usr/sbin/backup_{home,raiz}.cron
		dosym ../../usr/sbin/backup_home.cron /etc/cron.daily/backup_home.cron
		dosym ../../usr/sbin/backup_raiz.cron /etc/cron.daily/backup_raiz.cron
	fi

}
