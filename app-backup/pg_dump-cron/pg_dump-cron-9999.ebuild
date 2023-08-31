# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Backup for Postgresql."
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
	dev-db/postgresql:*"
RDEPEND="${DEPEND}"

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/pg_dump.cron
	dosym ../../usr/sbin/pg_dump.cron /etc/cron.daily/pg_dump.cron
}

pkg_postinst() {
	local file="${EROOT}/etc/backup-cron/backup-cron.conf"
	einfo "Don't forget set postgres password in DB_PG_PASSWD parameter at '${file}' script."
	einfo "If the backup is not generated check the BDB_PG_HOST parameter at '${file}' script."
}
