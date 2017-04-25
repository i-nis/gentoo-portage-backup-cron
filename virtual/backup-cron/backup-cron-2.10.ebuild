# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils git-2 user

DESCRIPTION="Config file and utilities for backup-cron scripts."
SRC_URI=""
EGIT_REPO_URI="https://github.com/ingeniovirtual/backup-cron.git"
EGIT_COMMIT="v${PV}"
IUSE="logcheck plugins sync"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="sys-apps/findutils
	mail-client/mailx
	sys-block/mbuffer
	logcheck? ( app-admin/logcheck )
	sync? ( app-backup/remote_backup_sync-cron )"
RDEPEND="${DEPEND}
	plugins? ( || (
		net-analyzer/monitoring-plugins
		net-analyzer/nagios-plugins
	) )"

src_unpack() {
	git-2_src_unpack
	cd "${S}"
}

pkg_setup() {
	# Add backup user and group, then check perms (issue #1)
	einfo "Checking for admin group..."
	enewgroup admin
	einfo "Checking for admin user..."
	enewuser admin -1 /bin/rbash /home/admin admin
	einfo "Setting permissions for /home/admin directory."
	dodir /home/admin
	fperms 0770 /home/admin
}

src_install() {
	dodir /etc/backup-cron
	dodir /usr/libexec/backup-cron
	cp -pR "${S}"/etc/backup-cron/backup-cron.conf "${D}"/etc/backup-cron
	cp -pR "${S}"/etc/backup-cron/exclude.txt "${D}"/etc/backup-cron
	cp -pR "${S}"/usr/libexec/backup-cron/backup-cron_functions.sh "${D}"/usr/libexec/backup-cron/

	if use logcheck ; then
		dodir /etc/logcheck/ignore.d.server
		cp -pR "${S}"/etc/logcheck/ignore.d.server/backup-cron "${D}"/etc/logcheck/ignore.d.server
	fi

	if use plugins ; then
		dodir /usr/lib/nagios/plugins
		exeinto /usr/lib/nagios/plugins
		doexe "${S}"/usr/lib/nagios/plugins/check_backup-cron
	fi

	einfo "Setting permissions for files in /etc/backup-cron."
	fperms 600 /etc/backup-cron/backup-cron.conf
	fperms 600 /etc/backup-cron/exclude.txt
}
