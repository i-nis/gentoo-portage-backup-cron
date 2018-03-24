# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit git-r3

DESCRIPTION="Backup for system configuration files in /etc."
HOMEPAGE="https://proyectos.ingeniovirtual.com.ar/projects/backup-cron"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingeniovirtual/backup-cron.git"
EGIT_COMMIT="v${PV}"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-admin/tmpwatch sys-process/vixie-cron >=virtual/backup-cron-2.9"
RDEPEND="${DEPEND}"

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/backup_etc.cron

	if [ ! -h /etc/cron.*/backup_etc.cron ]; then
			dosym "${EROOT}"/usr/sbin/backup_etc.cron /etc/cron.daily/backup_etc.cron
		else
			dosym "${EROOT}"/usr/sbin/backup_etc.cron $(ls /etc/cron.*/backup_etc.cron)
	fi

}
