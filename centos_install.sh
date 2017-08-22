wget -P http://storage.raidix.com/pub/linux/centos-mirror/7.3.1611/isos/x86_64/CentOS-7-x86_64-Minimal-1611.iso

mkdir /mnt/rdx45
mount -t iso9660 -o loop,ro /tmp/CentOS-7-x86_64-Minimal-1611.iso /mnt/rdx45

cobbler import --name=rdx45-103 --path=/mnt/rdx45/

#change ks

cobbler profile edit --name=centos73-x86_64 --kickstart=/var/lib/cobbler/kickstarts/centos73-1.ks 
cobbler system edit --name=initiator-1 --netboot-enable=1
