# wget --spider  http://storage.raidix.com/pub/raidix/raidix/4.5/centos7.2/iso/raidix-devel-4.5.0-103-x86_64.iso
wget -P /tmp http://storage.raidix.com/pub/raidix/raidix/4.5/centos7.2/iso/raidix-devel-4.5.0-103-x86_64.iso
mkdir /mnt/rdx45
mount -t iso9660 -o loop,ro /tmp/raidix-devel-4.5.0-103-x86_64.iso /mnt/rdx45
cobbler import --name=rdx45-103 --path=/mnt/rdx45/

cp /var/www/cobbler/ks_mirror/rdx45-103/ks.cfg /var/lib/cobbler/kickstarts/ks.cfg


rm -f /var/www/cobbler/ks_mirror/rdx45-103/LiveOS/squashfs.img
wget -P /var/www/cobbler/ks_mirror/rdx45-103/LiveOS/ http://storage.raidix.com/pub/linux/centos/vault/7.2.1511/os/x86_64/LiveOS/squashfs.img
cobbler profile edit --name=rdx45-103-x86_64 --kopts="method=http://172.16.21.138/cblr/ks_mirror/rdx45-103" --kickstart=/var/lib/cobbler/kickstarts/ks.cfg


cobbler system add --name=qemu --interface=net0 --mac=00:60:2f:a0:e9:f0 --static=1 --ip-address=172.16.20.241 --gateway=172.16.21.252 --netmask=255.255.252.0 --name-servers="192.168.60.1 192.168.60.4"
cobbler system edit --name=qemu --profile=rdx45-103-x86_64 
cobbler system edit --name=qemu --netboot-enabled=1


# /var/www/cobbler -> http://172.16.21.138/cblr

# default stack
# prompt 0
# label stack
#         kernel vmlinuz
#         append ks=https://172.16.21.138/install/ks.cfg root=live:https://172.16.21.138/install/squashfs.img method=http://172.16.20.33/raidix-testing-4.5.0/raidix-devel-4.5.0-101 devfs=nomount inst.noverifyssl inst.ks.sendmac no-parallel-format ramdisk_size=300000 initrd=initrd.img

# http://storage.raidix.com/pub/linux/centos/vault/7.2.1511/os/x86_64/LiveOS/
# http://storage.raidix.com/pub/raidix/raidix/4.5/centos7.2/iso/
# http://172.16.20.33/raidix-testing-4.5.0/