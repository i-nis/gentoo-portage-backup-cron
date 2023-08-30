# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Clear utility for old backups from remote hosts."
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
	cp -pR "${S}"/etc/cron.daily/clean_*.cron "${D}"/etc/cron.daily
	fperms 700 /etc/cron.daily/clean_*.cron
}

pkg_postinst() {
	local file="${ROOT}etc/backup-cron/backup-cron.conf"
	einfo "Do not forget to set the list of remote hosts in HOSTS parameter at '${file}' script."
}
