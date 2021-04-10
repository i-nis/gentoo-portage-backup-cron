# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils

DESCRIPTION="Backup for disk images of virtual machines managed by Libvirt."
HOMEPAGE="https://proyectos.nis.com.ar/projects/backup-cron"
SRC_URI="
	https://github.com/i-nis/backup-cron/archive/v${PV}.zip -> backup-cron-${PV}.zip
	https://gitlab.com/i-nis/backup-cron/-/archive/v${PV}/backup-cron-${PV}.zip -> backup-cron-${PV}.zip
	"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-admin/tmpwatch
	>=virtual/backup-cron-3.0
	virtual/cron
	app-emulation/libvirt"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/backup-cron-${PV}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	dodir /etc/cron.weekly
	dosbin "${S}"/usr/sbin/backup_libvirt.cron
	dosym ../../usr/sbin/backup_libvirt.cron /etc/cron.weekly/backup_libvirt.cron
}

pkg_postinst() {
	ewarn "See previous considerations at: "
	ewarn "https://proyectos.nis.com.ar/projects/backup-cron/wiki/Consideraciones_previas"
	einfo "This utility backs disk images of virtual machines managed by libvirt to the compressed qcow2 format."
	einfo "The backup files have .qcow2 file extension."
	einfo "More information about qcow2 in: https://people.gnome.org/~markmc/qcow-image-format.html"
}
