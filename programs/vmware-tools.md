# Install VMware Tools

We are using open-vm-tools, as recommend for [Ubuntu 14.x and above](https://kb.vmware.com/s/article/1022525).

## Install

```
sudo apt install open-vm-tools-desktop
```

## Configure Autostart
Autostart should work.

To enable copy+paste the following command must be run after xmonad is started

```
/usr/bin/vmware-user-suid-wrapper
```

This should happen automatically.

## Uninstall
If you want to uninstall VMware Tools again, run:
```shell
sudo apt remove --purge open-vm-tools-desktop
sudo apt autoremove
```
