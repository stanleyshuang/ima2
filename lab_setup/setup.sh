#!/usr/bin/env bash
base_dir=$(dirname "$0")

echo "1.0 Download and setup Vagrant and VirtualBox..."

if ! [ -d ~/vbox ]; then
  echo "mkdir ~/vbox"
        mkdir ~/vbox
fi

echo "VBoxManage setproperty machinefolder ~/vbox"
      VBoxManage setproperty machinefolder ~/vbox
