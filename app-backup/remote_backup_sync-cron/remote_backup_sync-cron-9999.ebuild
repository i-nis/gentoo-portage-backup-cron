# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils git-r3

DESCRIPTION="Backup sync for remote storage over SSH and rsync."
HOMEPAGE="https://proyectos.nis.com.ar/projects/backup-cron"
SRC_URI=""
EGIT_REPO_URI="https://github.com/i-nis/backup-cron.git"
EGIT_COMMIT="master"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-admin/tmpwatch
	virtual/cron
	virtual/backup-cron
	net-misc/rsync"
RDEPEND="${DEPEND}"

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/remote_backup_sync.cron

	if [ ! -h /etc/cron.*/remote_backup_sync.cron ]; then
			dosym "${EROOT}"/usr/sbin/remote_backup_sync.cron /etc/cron.daily/remote_backup_sync.cron
		else
			dosym "${EROOT}"/usr/sbin/remote_backup_sync.cron $(ls /etc/cron.*/remote_backup_sync.cron)
	fi

}
