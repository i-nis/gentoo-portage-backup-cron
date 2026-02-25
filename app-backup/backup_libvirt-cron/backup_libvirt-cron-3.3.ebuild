# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Backup for disk images of virtual machines managed by Libvirt."
HOMEPAGE="https://gitlab.nis.com.ar/proyectos/backup-cron"
SRC_URI="https://gitlab.nis.com.ar/proyectos/backup-cron/-/archive/v${PV}/backup-cron-v${PV}.tar.bz2 -> backup-cron-${PV}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="app-admin/tmpwatch
	>=app-backup/backup-cron-3.0
	app-emulation/libvirt"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/backup-cron-v${PV}" "${WORKDIR}/${P}" || die "Install failed!"
}

src_install() {
	dodir /etc/cron.weekly
	dosbin "${S}"/usr/sbin/backup_libvirt.cron
	dosym ../../usr/sbin/backup_libvirt.cron /etc/cron.weekly/backup_libvirt.cron
}

pkg_postinst() {
	ewarn "See previous considerations at: "
	ewarn "https://gitlab.nis.com.ar/proyectos/backup-cron/-/wikis/Consideraciones_previas"
	einfo "This utility backs disk images of virtual machines managed by libvirt to the compressed qcow2 format."
	einfo "The backup files have .qcow2 file extension."
	einfo "More information about qcow2 in: https://wiki.qemu.org/Features/Qcow3"
}
