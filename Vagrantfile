# -*- mode: ruby -*-
# vi: set ft=ruby :
$set_environment_variables = <<SCRIPT
echo "export ni=\\\"#{ENV['ni']}\\\"" >> ~/.profile
echo "export cnc_ip=\\\"#{ENV['cnc_ip']}\\\"" >> ~/.profile
echo "export ip_prx=\\\"#{ENV['ip_prx']}\\\"" >> ~/.profile
echo "export tgt_bgn=\\\"#{ENV['tgt_bgn']}\\\"" >> ~/.profile
echo "export tgt_end=\\\"#{ENV['tgt_end']}\\\"" >> ~/.profile
SCRIPT

Vagrant.configure("2") do |config|

    config.vm.define "mirai" do |mirai|
      mirai.vm.box = "ubuntu/xenial64"
      mirai.vm.network "public_network", bridge: ENV['ni'], ip: ENV['cnc_ip']
      mirai.vm.provision "shell", inline: $set_environment_variables, run: "always"
      mirai.vm.provision "shell", path: "configs/provision.sh"
      mirai.vm.hostname = "mirai"

      mirai.vm.provider "virtualbox" do |vb|
        vb.name = "mirai"
        vb.memory = "2048"
        vb.cpus = 2
        vb.customize ["modifyvm", :id, "--uartmode1", "disconnected"]
        vb.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
        vb.customize ["modifyvm", :id, "--uartmode1", "file", File::NULL]
      end
    end

    tgt_bgn = ENV['tgt_bgn'].to_i
    (0..10).each do |i|
      config.vm.define "target_#{i}" do |target|
        target.vm.network "public_network", bridge: ENV['ni'], ip: ENV['ip_prx'] + ".#{tgt_bgn+i}"
        target.vm.box = "moszeed/alpine-x86"
        target.vm.box_version = "3.9.2"
        target.ssh.shell = "sh"
        target.vm.synced_folder "mirai/", "/vagrant/mirai"
        target.vm.hostname = "target-#{i}"
        target.vm.provision "shell", inline: $set_environment_variables, run: "always"
        target.vm.provision "shell", path: "configs/provision_target.sh"
        
        target.vm.provider "virtualbox" do |vb|
          vb.name = "target_#{i}"
          vb.memory = "256"
          vb.cpus = 1
        end
      end
    end
  
end
