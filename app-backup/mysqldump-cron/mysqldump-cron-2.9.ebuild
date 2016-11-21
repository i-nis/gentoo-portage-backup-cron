# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit git-2

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
	>=virtual/backup-cron-2.9
	virtual/mysql"
RDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack
}

src_install() {
	dodir /etc/cron.daily
	dosbin ${S}/usr/sbin/mysqldump.cron

	if [ ! -h /etc/cron.*/mysqldump.cron ]; then
			dosym /usr/sbin/mysqldump.cron /etc/cron.daily/mysqldump.cron
		else
			dosym /usr/sbin/mysqldump.cron $(ls /etc/cron.*/mysqldump.cron)
	fi
}

pkg_postinst() {
	local file="${ROOT}etc/backup-cron/backup-cron.conf"
	einfo "Don't forget set root password in BDB_PASSWD parameter at '${file}' script."
}
