# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit git-r3

DESCRIPTION="Backup for Postgresql."
HOMEPAGE="https://proyectos.ingeniovirtual.com.ar/projects/backup-cron"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingeniovirtual/backup-cron.git"
EGIT_COMMIT="v${PV}"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-admin/tmpwatch
	virtual/cron
	virtual/backup-cron
	dev-db/postgresql:*"
RDEPEND="${DEPEND}"

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/pg_dump.cron

	if [ ! -h /etc/cron.*/pg_dump.cron ]; then
			dosym "${EROOT}"/usr/sbin/pg_dump.cron /etc/cron.daily/pg_dump.cron
		else
			dosym "${EROOT}"/usr/sbin/pg_dump.cron $(ls /etc/cron.*/pg_dump.cron)
	fi
}

pkg_postinst() {
	local file="${EROOT}/etc/backup-cron/backup-cron.conf"
	einfo "Don't forget set postgres password in DB_PG_PASSWD parameter at '${file}' script."
	einfo "If the backup is not generated check the BDB_PG_HOST parameter at '${file}' script."
}
