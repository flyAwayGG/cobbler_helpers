#!/usr/bin/bash

yum -y install epel-release
yum -y update
yum -y install createrepo httpd mkisofs mod_wsgi mod_ssl python-cheetah python-netaddr python-simplejson python-urlgrabber PyYAML rsync syslinux tftp-server yum-utils pykickstart cobbler fence-agents wget vim tftp tcpdump xinetd nmap

# Disable Selinux in /etc/sysconfig/selinux
# Enable TFTP in /etc/xinetd.d/tftp

# In /etc/cobbler/settings : 
# Set server : current ip 
# Set pxe_just_once: 1
# Decrease TIMEOUT in /etc/cobbler/pxe/pxedefault.template 

cp /usr/share/syslinux/pxelinux.0 /var/lib/cobbler/loaders/
#cp /usr/share/syslinux/chain.c32 /var/lib/tftpboot
#cp /usr/share/syslinux/vesamenu.c32 /var/lib/tftpboot

# Change ip to static
# Reboot

systemctl start httpd
systemctl enable httpd

systemctl start rsyncd.service
systemctl enable rsyncd.service

systemctl start tftp
systemctl enable tftp

systemctl start xinetd
systemctl enable xinetd

systemctl disable firewalld
systemctl stop firewall

systemctl start cobbler
systemctl enable cobbler

systemctl start cobblerd
systemctl enable cobblerd

cobbler get-loaders
cobbler sync

