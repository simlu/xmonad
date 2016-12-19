# 1) Ubuntu and Xmonad
> [Reference](http://askubuntu.com/questions/142061/can-i-completely-remove-gnome-and-leave-xmonad)

## a) Install MinimalCD version of Ubuntu
Find the latest [MinimalCD](https://help.ubuntu.com/community/Installation/MinimalCD) version for the Ubuntu you want to use, download and install with VMware.

Important: Ensure you allocate enough virtual machine memory, so that a decent amount of swap space is allocated.

## b) Install Xmonad
```shell
sudo apt-get update
sudo apt-get install xorg xinit
sudo apt-get install xmonad
```
Type `startx` to start xmonad.

# 2) Configuration
## a) Download Repo Content
```shell
cd downloads
wget https://github.com/simlu/xmonad/archive/master.zip
sudo apt-get install unzip
unzip master.zip
rm master.zip
```
## b) Copy Configs
It should be save to copy `config/*` to `~/.`. Details on what the different files are for can be found [here](config.md).

# 3) Install VMware Tools
> [Reference](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1022525)

We are using the iso coming from VMware as it includes the lastest VMware Tools. Most importantly it includes multi screen support. Discussion can be found [here](http://superuser.com/questions/270112/open-vm-tools-vs-vmware-tools).
## a) Mount CD
* Add a CD Drive to the VM
* Use `Install VM Tools`

## b) Install VMware
Download `scripts/update-vm-tools` and run it with 
```shell
. update-vm-tools
```
To confirm the installation worked correctly run
```shell
vmware-toolbox-cmd -v
```
When done feel free to remove the cd drive again in VMware.

## c) Configure Autostart
> [Reference](http://askubuntu.com/questions/777839/fresh-ubuntu-16-04-install-broken-vmware-tools#answer-777922)

To enable vm tools you need to run `/usr/bin/vmware-user`.

To enable this as autostart, copy `config/.xmonad/autostart` to `~/.xmonad/autostart`.

# 4) Install Chrome
Instructions can be found [here](programs/chrome.md).

# 5) Install Xmonad Configuration and XMobar
## a) Download Xmonad Config
Download `config/.xmonad/xmonad.hs` and copy to `~/.xmonad/xmonad.hs` locally.
## b) Install XMobar
- Search [Releases](http://projects.haskell.org/xmobar/releases.html)
- Find latest deb file here: https://pkgs.org/search/xmobar
- Install deb file by using
```shell
sudo apt-get install libiw30
sudo dpkg -i xmobar_x.xx.x-x_amd64.deb
```
## c) Install XMobar Config
Copy file `config/.xmobarrc` to local `~/.xmobarrc`

# 6) Autostart Xmonad
> [Reference](https://linuxexpresso.wordpress.com/2010/10/03/startx-automatically-on-login-ubuntu/)

```shell
cp /etc/skel/.profile ~/.profile
```
Append the following to `~/.profile`
```shell
# start xmonad on login
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
 . startx
 logout
fi
```
Recompile xmonad
```shell
xmonad --recompile && xmonad --restart
```
