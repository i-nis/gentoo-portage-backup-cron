# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="A user for virtual/backup-cron."

ACCT_USER_GROUPS=( "${PN}" )
ACCT_USER_ID="-1"
ACCT_USER_HOME="/home/${PN}"
ACCT_USER_HOME_PERMS=0770
ACCT_USER_SHELL="/bin/rbash"

acct-user_add_deps
