# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Config file and utilities for backup-cron scripts."
HOMEPAGE="https://gitlab.nis.com.ar/proyectos/backup-cron"
SRC_URI="https://gitlab.nis.com.ar/proyectos/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${PN}-${PV}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="logcheck plugins sync"
DEPEND="
	acct-group/admin
	acct-user/admin
	app-alternatives/awk
	app-alternatives/bzip2
	app-alternatives/tar
	app-crypt/gnupg
	app-admin/eselect
	net-misc/rsync
	sys-apps/findutils
	net-mail/mailutils
	|| ( virtual/cron sys-process/anacron )
	logcheck? ( app-admin/logcheck )
	sync? ( app-backup/remote_backup_sync-cron )"
RDEPEND="${DEPEND}
	plugins? ( || (
		net-analyzer/monitoring-plugins
		net-analyzer/nagios-plugins
	) )"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${PN}-v${PV}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	dodir /etc/backup-cron
	dodir /usr/libexec/backup-cron
	dodir /usr/share/eselect/modules
	dosbin "${S}"/usr/sbin/backup_restore
	cp -pR "${S}"/etc/backup-cron/backup-cron.conf "${D}"/etc/backup-cron
	cp -pR "${S}"/etc/backup-cron/exclude.txt "${D}"/etc/backup-cron
	cp -pR "${S}"/usr/libexec/backup-cron/backup-cron_functions.sh "${D}"/usr/libexec/backup-cron/
	cp -pR "${S}"/usr/share/eselect/modules/backup-cron.eselect "${D}"/usr/share/eselect/modules/

	if use logcheck ; then
		dodir /etc/logcheck/ignore.d.server
		cp -pR "${S}"/etc/logcheck/ignore.d.server/backup-cron "${D}"/etc/logcheck/ignore.d.server
	fi

	if use plugins ; then
		exeinto /usr/$(get_libdir)/nagios/plugins
		doexe "${S}"/usr/lib/nagios/plugins/check_backup-cron
	fi

	einfo "Setting permissions for files in /etc/backup-cron."
	fperms 640 /etc/backup-cron/backup-cron.conf
	fperms 600 /etc/backup-cron/exclude.txt
}
