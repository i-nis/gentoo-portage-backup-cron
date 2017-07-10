# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit git-2

DESCRIPTION="Backup for Postgresql."
HOMEPAGE="https://proyectos.ingeniovirtual.com.ar/projects/backup-cron"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingeniovirtual/backup-cron.git"
EGIT_COMMIT="v${PV}"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-amd64 -x86"
DEPEND="app-admin/tmpwatch
	sys-process/vixie-cron
	>=virtual/backup-cron-2.9
	dev-db/postgresql"
RDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack
}

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/pg_dump.cron

	if [ ! -h /etc/cron.*/pg_dump.cron ]; then
			dosym /usr/sbin/pg_dump.cron /etc/cron.daily/pg_dump.cron
		else
			dosym /usr/sbin/pg_dump.cron $(ls /etc/cron.*/pg_dump.cron)
	fi
}

pkg_postinst() {
	local file="${ROOT}etc/backup-cron/backup-cron.conf"
	einfo "Don't forget set postgres password in DB_PG_PASSWD parameter at '${file}' script."
}
