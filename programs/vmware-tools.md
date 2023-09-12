# Install VMware Tools

We are using open-vm-tools, as recommend for [Ubuntu 14.x and above](https://kb.vmware.com/s/article/1022525).

## Install
Run
```shell
sudo apt install open-vm-tools-desktop
```
To confirm the installation worked correctly run
```shell
vmware-toolbox-cmd -v
```

## Configure Autostart
Autostart should work, to fix shared clipboard bug, see here: https://github.com/systemd/systemd/issues/27919#issuecomment-1577864234

## Uninstall
If you want to uninstall VMware Tools again, run:
```shell
sudo /usr/bin/vmware-uninstall-tools.pl
```
