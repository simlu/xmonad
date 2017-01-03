# 1) Ubuntu and Xmonad
> [Reference](http://askubuntu.com/questions/142061/can-i-completely-remove-gnome-and-leave-xmonad)

## a) Install MinimalCD version of Ubuntu
Find the latest [MinimalCD](https://help.ubuntu.com/community/Installation/MinimalCD) version for the Ubuntu you want to use, download and install with VMware.

**Important:** Ensure you allocate enough virtual machine memory, so that a decent amount of swap space is allocated.

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
Is should now be save to copy the configurations:
```shell
mv -v ~/xmonad-master/config/* ~/
```
Details on what the different files are for can be found [here](config.md).

# 3) VMware Tools or VirtualBox Guest Additions
* Instuctions for VMware Tools [here](programs/vmware-tools.md)
* Instructions for VirtualBox Guest Additions [here](programs/virtualbox-guest-additions.md)
* If you are using physical hardware you can skip this step

# 4) Install Chrome
Instructions [here](programs/chrome.md). Feel free to install another browser like [Firefox](https://help.ubuntu.com/community/FirefoxNewVersion) instead.

# 5) Install Taffybar

## Install Dependency
```shell
sudo apt-get install libiw30
```

## Install Latest Deb
* Search [Releases](https://github.com/travitch/taffybar/releases)
* Find latest deb file [here](https://pkgs.org/download/taffybar)
* Install deb file by using

```shell
sudo dpkg -i taffybar_x.x.x-x_amd64.deb
```
> Latest at time of writing is [taffybar_0.4.6-3_amd64.deb](http://archive.ubuntu.com/ubuntu/pool/universe/t/taffybar/taffybar_0.4.6-3_amd64.deb) (Released Jan 11, 2016)


# 6) Configure XMonad Autostart
> [Reference](https://linuxexpresso.wordpress.com/2010/10/03/startx-automatically-on-login-ubuntu/)

Copy skeleton `.profile` file into home.
```shell
cp /etc/skel/.profile ~/.profile
```
Append the following to `~/.profile`:
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
and restart
```shell
sudo reboot -h now
```

# 7) Install other Programs
Install instructions for some selected programs can be found [here](programs/).
