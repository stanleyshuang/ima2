#!/bin/sh
apk update
apk add virtualbox-guest-additions virtualbox-guest-modules-virt

### add account admin/admin
adduser --disabled-password admin
adduser admin wheel
echo "admin:admin" | chpasswd

### install telnetd
apk add busybox-extras
telnetd
