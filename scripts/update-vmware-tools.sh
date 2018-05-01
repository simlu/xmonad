#!/bin/bash
# exit on error
set -e

# check if root
if [ "$(whoami)" != "root" ] ; then
    echo "please run as sudo"
    exit;
fi

# run logic
mkdir ~/tmp-mnt-cdrom
sudo mount /dev/cdrom ~/tmp-mnt-cdrom
mkdir ~/tmp-vmware-tools-install
tar -xzvf ~/tmp-mnt-cdrom/VMwareTools-*.tar.gz -C ~/tmp-vmware-tools-install
(cd ~/tmp-vmware-tools-install/vmware-tools-distrib/ && sudo ./vmware-install.pl -f -d)
umount ~/tmp-mnt-cdrom || /bin/true
rmdir ~/tmp-mnt-cdrom
rm -rf ~/tmp-vmware-tools-install/vmware-tools-distrib/
rmdir ~/tmp-vmware-tools-install
