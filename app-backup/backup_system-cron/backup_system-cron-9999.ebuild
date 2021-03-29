# Copyright 1999-2021 Gentoo Autors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils git-r3

DESCRIPTION="Backup for all files in the system."
HOMEPAGE="https://proyectos.nis.com.ar/projects/backup-cron"
SRC_URI=""
EGIT_REPO_URI="https://github.com/i-nis/backup-cron.git"
EGIT_COMMIT="master"
IUSE="no-home no-system var-only"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-admin/tmpwatch
	virtual/cron
	virtual/backup-cron"
RDEPEND="${DEPEND}"

src_install() {
	dodir /etc/cron.weekly

	# USE conditional blocks...
	if use no-home ; then
		dosbin "${S}"/usr/sbin/backup_{raiz,usr,var}.cron

		if [ ! -h /etc/cron.*/backup_raiz.cron ]; then
				dosym "${EROOT}"/usr/sbin/backup_raiz.cron /etc/cron.weekly/backup_raiz.cron
			else
				dosym "${EROOT}"/usr/sbin/backup_raiz.cron $(ls /etc/cron.*/backup_raiz.cron)
		fi

		if [ ! -h /etc/cron.*/backup_usr.cron ]; then
				dosym "${EROOT}"/usr/sbin/backup_usr.cron /etc/cron.weekly/backup_usr.cron
			else
				dosym "${EROOT}"/usr/sbin/backup_usr.cron $(ls /etc/cron.*/backup_usr.cron)
		fi

		if [ ! -h /etc/cron.*/backup_var.cron ]; then
				dosym "${EROOT}"/usr/sbin/backup_var.cron /etc/cron.weekly/backup_var.cron
			else
				dosym "${EROOT}"/usr/sbin/backup_var.cron $(ls /etc/cron.*/backup_var.cron)
		fi

	elif use no-system ; then
		dosbin "${S}"/usr/sbin/backup_home.cron

		if [ ! -h /etc/cron.*/backup_home.cron ]; then
				dosym "${EROOT}"/usr/sbin/backup_home.cron /etc/cron.weekly/backup_home.cron
			else
				dosym "${EROOT}"/usr/sbin/backup_home.cron $(ls /etc/cron.*/backup_home.cron)
		fi

	elif use var-only ; then
		dosbin "${S}"/usr/sbin/backup_var.cron

		if [ ! -h /etc/cron.*/backup_var.cron ]; then
				dosym "${EROOT}"/usr/sbin/backup_var.cron /etc/cron.weekly/backup_var.cron
			else
				dosym "${EROOT}"/usr/sbin/backup_var.cron $(ls /etc/cron.*/backup_var.cron)
		fi

	else
		dosbin "${S}"/usr/sbin/backup_{home,raiz,usr,var}.cron

		if [ ! -h /etc/cron.*/backup_home.cron ]; then
				dosym "${EROOT}"/usr/sbin/backup_home.cron /etc/cron.weekly/backup_home.cron
			else
				dosym "${EROOT}"/usr/sbin/backup_home.cron $(ls /etc/cron.*/backup_home.cron)
		fi

		if [ ! -h /etc/cron.*/backup_raiz.cron ]; then
				dosym "${EROOT}"/usr/sbin/backup_raiz.cron /etc/cron.weekly/backup_raiz.cron
			else
				dosym "${EROOT}"/usr/sbin/backup_raiz.cron $(ls /etc/cron.*/backup_raiz.cron)
		fi

		if [ ! -h /etc/cron.*/backup_usr.cron ]; then
				dosym "${EROOT}"/usr/sbin/backup_usr.cron /etc/cron.weekly/backup_usr.cron
			else
				dosym "${EROOT}"/usr/sbin/backup_usr.cron $(ls /etc/cron.*/backup_usr.cron)
		fi

		if [ ! -h /etc/cron.*/backup_var.cron ]; then
				dosym "${EROOT}"/usr/sbin/backup_var.cron /etc/cron.weekly/backup_var.cron
			else
				dosym "${EROOT}"/usr/sbin/backup_var.cron $(ls /etc/cron.*/backup_var.cron)
		fi

	fi

}
