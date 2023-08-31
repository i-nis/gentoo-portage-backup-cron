# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Backup for system configuration files in /etc."
HOMEPAGE="https://proyectos.nis.com.ar/projects/backup-cron"
IUSE=""
LICENSE="GPL-3"
SLOT="0"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/i-nis/backup-cron.git"
else
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="app-admin/tmpwatch virtual/cron virtual/backup-cron"
RDEPEND="${DEPEND}"

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/backup_etc.cron
	dosym ../../usr/sbin/backup_etc.cron /etc/cron.daily/backup_etc.cron
}
