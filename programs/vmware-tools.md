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
> [Reference](http://askubuntu.com/questions/777839/fresh-ubuntu-16-04-install-broken-vmware-tools#answer-777922)

Disable autostarts as it is broken:
```sh
sudo systemctl disable vgauth.service
sudo systemctl disable vmtoolsd.service // or similar
```

To enable vm tools you need to run `/usr/bin/vmware-user`.

Autostart is automatically enabled through the `config/.xmonad/autostart` file (as per install instructions). The `autostart` file is safe to keep around, as it will only fire when VMware Tools are installed.

## Uninstall
If you want to uninstall VMware Tools again, run:
```shell
sudo /usr/bin/vmware-uninstall-tools.pl
```
