# Install VMware Tools

We are using open-vm-tools, as recommend for [Ubuntu 14.x and above](https://kb.vmware.com/s/article/1022525).

## Install

1. Create empty CD drive for vm.
2. Start VM and click `VM > Install VM Tools`
3. In the VM run

```sh
sudo mkdir /mnt/cdrom
sudo mount /dev/cdrom /mnt/cdrom
cp /mnt/cdrom/VMwareTools-version.tar.gz .
sudo umount /mnt/cdrom
sudo rmdir /mnt/cdrom
tar -zxvf VMwareTools-version.tar.gz
rm VMWareTools-version.tar.gz
cd vmware-tools-distrib
./vmware-install.pl
```
4. Follow prompts and install
5. `rm -rf vmware-tools-distrib`

## Configure Autostart
Autostart should work. To enable the shared clipboard you need to run `/usr/bin/vmware-user-suid-wrapper`

## Uninstall
If you want to uninstall VMware Tools again, run:
```shell
sudo /usr/bin/vmware-uninstall-tools.pl
```
