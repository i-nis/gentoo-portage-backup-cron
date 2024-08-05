# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Backup for system configuration files in /etc."
HOMEPAGE="https://proyectos.nis.com.ar/projects/backup-cron"
LICENSE="GPL-3"
SLOT="0"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/i-nis/backup-cron.git"
else
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="app-admin/tmpwatch app-backup/backup-cron virtual/cron"
RDEPEND="${DEPEND}"

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/backup_etc.cron
	dosym ../../usr/sbin/backup_etc.cron /etc/cron.daily/backup_etc.cron
}
