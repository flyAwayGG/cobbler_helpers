# cobbler system add --name=ATI-1 --interface=net0 --mac=96:F5:A3:0F:95:91 --static=1 --ip-address=172.16.21.165 --gateway=172.16.21.252 --netmask=255.255.252.0 --name-servers="192.168.60.1 192.168.60.4"
# cobbler system add --name=ATI-2 --interface=net0 --mac=AA:75:C4:96:3D:34 --static=1 --ip-address=172.16.21.166 --gateway=172.16.21.252 --netmask=255.255.252.0 --name-servers="192.168.60.1 192.168.60.4"
# cobbler system add --name=centos-7 --interface=net0 --mac=26:BA:51:EE:3A:0B --static=1 --ip-address=172.16.21.130 --gateway=172.16.21.252 --netmask=255.255.252.0 --name-servers="192.168.60.1 192.168.60.4"

# # change ks.cfg
# #CHANGED#
# eula --agreed
# # System timezone
# timezone Europe/Moscow --isUtc --ntpservers=0.centos.pool.ntp.org,1.centos.pool.ntp.org,2.centos.pool.ntp.org,3.centos.pool.ntp.org
# # System bootloader configuration
# bootloader --location=mbr --boot-drive=sda
# autopart --type=lvm
# zerombr
# # Partition clearing information
# clearpart --all --drives=sda
# ignoredisk --only-use=sda
# reboot

# %pre
# $SNIPPET('kickstart_start')
# $SNIPPET('pre_install_network_config')
# %end

# $SNIPPET('network_config')

# %post
# $SNIPPET('post_install_network_config')
# $SNIPPET('kickstart_done')
# %end