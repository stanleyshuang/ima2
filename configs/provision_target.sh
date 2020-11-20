#!/bin/sh
apk update

### add account admin/admin
adduser --disabled-password admin
adduser admin wheel
echo "admin:admin" | chpasswd

### install telnetd
apk add busybox-extras
telnetd
