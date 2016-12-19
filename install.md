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

# 3) Install VMware Tools
Instuctions [here](programs/vmware-tools.md). If you are using VirtualBox, you need to install [VirtualBox Guest Additions](http://askubuntu.com/questions/792832/how-to-install-virtualbox-guest-additions-for-ubuntu-16-04) instead.

# 4) Install Chrome
Instructions [here](programs/chrome.md). Feel free to install another browser like [Firefox](https://help.ubuntu.com/community/FirefoxNewVersion) instead.

# 5) Install Xmobar
- Search [Releases](http://projects.haskell.org/xmobar/releases.html)
- Find latest deb file here: https://pkgs.org/search/xmobar
- Install deb file by using
```shell
sudo apt-get install libiw30
sudo dpkg -i xmobar_x.xx.x-x_amd64.deb
```
> At time of writing the latest deb is [xmobar_0.24.3-2_amd64.deb](http://ftp.br.debian.org/debian/pool/main/x/xmobar/xmobar_0.24.3-2_amd64.deb) (Released Sep 5, 2016)

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
