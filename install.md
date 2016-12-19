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
Instuctions [here](programs/vmware-tools.md).

# 4) Install Chrome
Instructions [here](programs/chrome.md).

# 5) Xmobar
## a) Install
- Search [Releases](http://projects.haskell.org/xmobar/releases.html)
- Find latest deb file here: https://pkgs.org/search/xmobar
- Install deb file by using
```shell
sudo apt-get install libiw30
sudo dpkg -i xmobar_x.xx.x-x_amd64.deb
```
## b) Autostart
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
