# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit git-r3

DESCRIPTION="Backup for MySQL."
HOMEPAGE="https://proyectos.ingeniovirtual.com.ar/projects/backup-cron"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingeniovirtual/backup-cron.git"
EGIT_COMMIT="v${PV}"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-admin/tmpwatch
	sys-process/vixie-cron
	>=virtual/backup-cron-2.11
	virtual/mysql"
RDEPEND="${DEPEND}"

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/mysqldump.cron

	if [ ! -h /etc/cron.*/mysqldump.cron ]; then
			dosym "${EROOT}"/usr/sbin/mysqldump.cron /etc/cron.daily/mysqldump.cron
		else
			dosym "${EROOT}"/usr/sbin/mysqldump.cron $(ls /etc/cron.*/mysqldump.cron)
	fi
}

pkg_postinst() {
	local file="${EROOT}/etc/backup-cron/backup-cron.conf"
	einfo "Don't forget set root password in BDB_PASSWD parameter at '${file}' script."
}
