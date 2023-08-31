# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Backup sync for remote storage over SSH and rsync."
HOMEPAGE="https://proyectos.nis.com.ar/projects/backup-cron"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/i-nis/backup-cron.git"
else
	KEYWORDS="~amd64 ~x86"
fi

IUSE=""
LICENSE="GPL-3"
SLOT="0"
DEPEND="app-admin/tmpwatch
	virtual/cron
	virtual/backup-cron
	net-misc/rsync"
RDEPEND="${DEPEND}"

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/remote_backup_sync.cron
	dosym ../../usr/sbin/remote_backup_sync.cron /etc/cron.daily/remote_backup_sync.cron
}
