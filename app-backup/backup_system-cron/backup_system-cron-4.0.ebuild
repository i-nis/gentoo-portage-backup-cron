# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Backup for all files in the system"
HOMEPAGE="https://gitlab.nis.com.ar/proyectos/backup-cron"
SRC_URI="https://gitlab.nis.com.ar/proyectos/backup-cron/-/archive/v${PV}/backup-cron-v${PV}.tar.bz2 -> backup-cron-${PV}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="no-home no-system usr-only var-only"
DEPEND="app-admin/tmpwatch >=app-backup/backup-cron-4.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/backup-cron-v${PV}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	dodir /etc/cron.daily
	dodir /etc/cron.monthly/
	cp -pR "${S}"/etc/cron.monthly/00_backup_raiz "${D}"/etc/cron.monthly
	fperms 700 /etc/cron.daily/00_backup_raiz

	# USE conditional blocks...
	if use no-home ; then
		dosbin "${S}"/usr/sbin/backup_raiz
		dosym ../../usr/sbin/backup_raiz /etc/cron.daily/backup_raiz
	elif use no-system ; then
		dosbin "${S}"/usr/sbin/backup_home
		dosym ../../usr/sbin/backup_home /etc/cron.daily/backup_home
	elif use usr-only ; then
		dosbin "${S}"/usr/sbin/backup_usr
		dosym ../../usr/sbin/backup_usr /etc/cron.daily/backup_usr
	elif use var-only ; then
		dosbin "${S}"/usr/sbin/backup_var
		dosym ../../usr/sbin/backup_var /etc/cron.daily/backup_var
	else
		dosbin "${S}"/usr/sbin/backup_{home,raiz}
		dosym ../../usr/sbin/backup_home /etc/cron.daily/backup_home
		dosym ../../usr/sbin/backup_raiz /etc/cron.daily/backup_raiz
	fi

}
