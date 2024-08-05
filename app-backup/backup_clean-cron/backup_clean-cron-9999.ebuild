# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Clear utility for old backups from remote hosts."
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
	cp -pR "${S}"/etc/cron.daily/clean_*.cron "${D}"/etc/cron.daily
	fperms 700 /etc/cron.daily/clean_*.cron
}

pkg_postinst() {
	local file="${ROOT}/etc/backup-cron/backup-cron.conf"
	einfo "Do not forget to set the list of remote hosts in HOSTS parameter at '${file}' script."
}
