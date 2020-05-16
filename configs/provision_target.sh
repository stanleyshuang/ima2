#!/bin/sh

### add account admin/admin
adduser -D admin
echo "admin:admin" | chpasswd

### install telnetd
apk update
apk add busybox-extras
telnetd
