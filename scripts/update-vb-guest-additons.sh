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
sudo ~/tmp-mnt-cdrom/VBoxLinuxAdditions.run
sudo umount ~/tmp-mnt-cdrom || /bin/true
rm -rf ~/tmp-mnt-cdrom
