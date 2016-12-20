# Install VMware Tools
> [Reference](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1022525)

We are using the iso coming from VMware as it includes the lastest VMware Tools. Most importantly it includes multi screen support. Discussion can be found [here](http://superuser.com/questions/270112/open-vm-tools-vs-vmware-tools).
## Mount CD
* Add a CD Drive to the VM
* Use `Install VM Tools`

## Install VMware
Download [scripts/update-vmware-tools.sh](/scripts/update-vmware-tools.sh) and run it with 
```shell
sudo bash update-vm-tools.sh
```
To confirm the installation worked correctly run
```shell
vmware-toolbox-cmd -v
```
When done feel free to remove the cd drive again in VMware.

## Configure Autostart
> [Reference](http://askubuntu.com/questions/777839/fresh-ubuntu-16-04-install-broken-vmware-tools#answer-777922)

To enable vm tools you need to run `/usr/bin/vmware-user`.

To enable this as autostart, copy `config/.xmonad/autostart` to `~/.xmonad/autostart`. The `autostart` file is safe to keep around, as it will only fire when VMware Tools are installed.

## Uninstall
If you want to uninstall VMware Tools again, run:
```shell
sudo /usr/bin/vmware-uninstall-tools.pl
```
