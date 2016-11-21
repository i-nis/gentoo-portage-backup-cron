# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit git-2

DESCRIPTION="Backup sync for remote storage over SSH and rsync."
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
	>=virtual/backup-cron-2.9
	net-misc/rsync"
RDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack
}

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/remote_backup_sync.cron

	if [ ! -h /etc/cron.*/remote_backup_sync.cron ]; then
			dosym /usr/sbin/remote_backup_sync.cron /etc/cron.daily/remote_backup_sync.cron
		else
			dosym /usr/sbin/remote_backup_sync.cron $(ls /etc/cron.*/remote_backup_sync.cron)
	fi

}
