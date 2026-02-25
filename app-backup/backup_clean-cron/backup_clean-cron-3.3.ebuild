# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Clear utility for old backups from remote hosts."
HOMEPAGE="https://gitlab.nis.com.ar/proyectos/backup-cron"
SRC_URI="https://gitlab.nis.com.ar/proyectos/backup-cron/-/archive/v${PV}/backup-cron-v${PV}.tar.bz2 -> backup-cron-${PV}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-admin/tmpwatch >=app-backup/backup-cron-3.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/backup-cron-v${PV}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	dodir /etc/cron.daily
	cp -pR "${S}"/etc/cron.daily/clean_*.cron "${D}"/etc/cron.daily
	fperms 700 /etc/cron.daily/clean_*.cron
}

pkg_postinst() {
	local file="${ROOT}/etc/backup-cron/backup-cron.conf"
	einfo "Do not forget to set the list of remote hosts in HOSTS parameter at '${file}' script."
}
