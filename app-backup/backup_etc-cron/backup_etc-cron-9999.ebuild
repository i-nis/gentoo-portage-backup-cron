# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Backup for system configuration files in /etc."
HOMEPAGE="https://proyectos.nis.com.ar/projects/backup-cron"
SRC_URI=""
EGIT_REPO_URI="https://github.com/i-nis/backup-cron.git"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-admin/tmpwatch virtual/cron virtual/backup-cron"
RDEPEND="${DEPEND}"

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/backup_etc.cron
	dosym ../../usr/sbin/backup_etc.cron /etc/cron.daily/backup_etc.cron
}
