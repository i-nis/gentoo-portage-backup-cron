# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils multilib

DESCRIPTION="Config file and utilities for backup-cron scripts."
SRC_URI="https://github.com/i-nis/${PN}/archive/v${PV}.zip -> backup-cron-${PV}.zip"
IUSE="logcheck plugins sync"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="
	acct-group/admin
	acct-user/admin
	app-crypt/gnupg
	sys-apps/findutils
	net-mail/mailutils
	sys-block/mbuffer
	logcheck? ( app-admin/logcheck )
	sync? ( app-backup/remote_backup_sync-cron )"
RDEPEND="${DEPEND}
	plugins? ( || (
		net-analyzer/monitoring-plugins
		net-analyzer/nagios-plugins
	) )"

src_install() {
	dodir /etc/backup-cron
	dodir /usr/libexec/backup-cron
	dosbin "${S}"/usr/sbin/backup_restore
	cp -pR "${S}"/etc/backup-cron/backup-cron.conf "${D}"/etc/backup-cron
	cp -pR "${S}"/etc/backup-cron/exclude.txt "${D}"/etc/backup-cron
	cp -pR "${S}"/usr/libexec/backup-cron/backup-cron_functions.sh "${D}"/usr/libexec/backup-cron/

	if use logcheck ; then
		dodir /etc/logcheck/ignore.d.server
		cp -pR "${S}"/etc/logcheck/ignore.d.server/backup-cron "${D}"/etc/logcheck/ignore.d.server
	fi

	if use plugins ; then
		dodir /usr/$(get_libdir)/nagios/plugins
		exeinto /usr/$(get_libdir)/nagios/plugins
		doexe "${S}"/usr/lib/nagios/plugins/check_backup-cron
	fi

	einfo "Setting permissions for files in /etc/backup-cron."
	fperms 640 /etc/backup-cron/backup-cron.conf
	fperms 600 /etc/backup-cron/exclude.txt
}
