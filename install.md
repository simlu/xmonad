> **Hint**: You can use "Edit > Paste" in VMWare to paste commands until the shared clipboard is operational.

# 1) Ubuntu and Xmonad
> [Reference](http://askubuntu.com/questions/142061/can-i-completely-remove-gnome-and-leave-xmonad)

## a) Install Server Version of Ubuntu

Install most barebone server version.

> Tested with Ubuntu 22.04 LTS

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

## c) Start Xmonad

You should be good to start xmonad now using `startx`.

# 3) VMware Tools or VirtualBox Guest Additions
* Instuctions for VMware Tools [here](programs/vmware-tools.md)
* Instructions for VirtualBox Guest Additions [here](programs/virtualbox-guest-additions.md)
* If you are using physical hardware you can skip this step

# 4) Install Chrome

## a) Enable all Mouse Buttons
To allow for mouse button 4 and 5 to operate, please edit the vmware VM \*.vmx file and append
```sh
mouse.vusb.enable = "TRUE"
mouse.vusb.useBasicMouse = "FALSE"
usb.generic.allowHID = "TRUE"
```

## b) Install
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

# 6) Basic Configuration

## Terminal Font Size

Append the following to `~/.Xresources`:
```
! Use a truetype font and size.
xterm*faceName: Monospace
xterm*faceSize: 14
```

Merge Settings
```
xrdb -merge ~/.Xresources
```

# 7) Install other Programs
Install instructions for some selected programs can be found [here](programs/).
