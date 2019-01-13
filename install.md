> **Hint**: You can use "Edit > Paste" in VMWare to paste commands until the shared clipboard is operational.

# 1) Ubuntu and Xmonad
> [Reference](http://askubuntu.com/questions/142061/can-i-completely-remove-gnome-and-leave-xmonad)

## a) Install MinimalCD version of Ubuntu
Find the latest [MinimalCD](https://help.ubuntu.com/community/Installation/MinimalCD) version for the Ubuntu you want to use, download and install with VMware.

> Tested with [Ubuntu 18.04 LTS](http://archive.ubuntu.com/ubuntu/dists/bionic/main/installer-amd64/current/images/netboot/mini.iso)

**Important:** Ensure you allocate enough virtual machine memory, so that a decent amount of swap space is allocated.

## b) Install Xmonad and Xmobar
```shell
sudo apt-get update
sudo apt-get install xterm xorg xinit xmonad xmobar
```

We need to disable super keys to allow xmonad shortcuts to work.

Install
```shell
sudo apt-get install gconf2
```

and run `gconftool-2 --set "/apps/compiz-1/plugins/unityshell/screen0/options/show_launcher" --type string ""`

Now restart the OS so the settings are loaded.

# 2) Configuration
## a) Download Repo Content
```shell
mkdir ~/Downloads
cd ~/Downloads
wget https://github.com/simlu/xmonad/archive/master.zip
sudo apt-get install unzip
unzip master.zip
rm master.zip
```
## b) Copy Configs
Ensure dotglob is enabled by running
```shell
shopt -s dotglob
```
It should now be safe to copy the configurations:
```shell
cp -a ~/Downloads/xmonad-master/config/. ~/
```
Details on what the different files are for can be found [here](config.md). 

Some files need to be merged after copying them. So we need to run for all prepend files, e.g.
```
cat ~/.bashrc >> ~/.bashrc-prepend
mv --force ~/.bashrc-prepend ~/.bashrc
```

# 3) VMware Tools or VirtualBox Guest Additions
* Instuctions for VMware Tools [here](programs/vmware-tools.md)
* Instructions for VirtualBox Guest Additions [here](programs/virtualbox-guest-additions.md)
* If you are using physical hardware you can skip this step

# 4) Install Chrome
Instructions [here](programs/chrome.md). Feel free to install another browser like [Firefox](https://help.ubuntu.com/community/FirefoxNewVersion) instead.

# 5) Configure XMonad Autostart
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

# 6) Install other Programs
Install instructions for some selected programs can be found [here](programs/).
