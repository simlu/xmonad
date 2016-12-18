# 1) Ubuntu and Xmonad
Reference: http://askubuntu.com/questions/142061/can-i-completely-remove-gnome-and-leave-xmonad

## a) Install MinimalCD version of Ubuntu
> Link: [MinimalCD](https://help.ubuntu.com/community/Installation/MinimalCD)

Note: Ensure you allocate enough virtual machine memory, so that a decent amount of swap space is allocated.

## b) Install XMonad
```shell
sudo apt-get update
sudo apt-get install xorg xinit
sudo apt-get install xmonad
```
Type `startx` to start xmonad.

## c) Autstart XMonad
> Reference: https://linuxexpresso.wordpress.com/2010/10/03/startx-automatically-on-login-ubuntu/

To automatically start xmonad after login we edit `~/.profile` and add:
```shell
# start xmonad on login
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
 . startx
 logout
fi
```
If the file doesn't exist already we can copy it from `/etc/skel/.profile`.

# 2) Update Keyboard if necessary
Reference: http://askubuntu.com/questions/342066/how-to-permanently-configure-keyboard
```shell
sudo dpkg-reconfigure keyboard-configuration
```

# 3) Install Chrome
Reference: http://askubuntu.com/questions/510056/how-to-install-google-chrome
```shell
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update 
sudo apt-get install google-chrome-stable
```
Then configure the alias `chrome`:
```shell
vi .bash_aliases
```
Then enter:
```shell
alias chrome='/opt/google/chrome/google-chrome --enable-plugins &> /dev/null &'
```

Dont forget to install [Adblock Plus](https://chrome.google.com/webstore/detail/adblock-plus/cfhdojbkjhnklbpkdaibdccddilifddb).

# 4) Add `apt-get-repository` command
Reference: http://askubuntu.com/questions/493460/how-to-install-add-apt-repository-using-the-terminal
```shell
sudo apt-get install software-properties-common
```

# 5) Install Java 8
Reference: http://tecadmin.net/install-oracle-java-8-jdk-8-ubuntu-via-ppa/#
```shell
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
java -version
sudo apt-get install oracle-java8-set-default
```

# 6) Install VMWare Tools
## a) 
Reference: https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1022525
```shell
sudo apt-get install open-vm-tools-desktop
```
## b)
To enable vm tools you need to run `/usr/bin/vmware-user-suid-wrapper`.
Reference: http://askubuntu.com/questions/777839/fresh-ubuntu-16-04-install-broken-vmware-tools#answer-777922

To enable this as autostart, copy `.xmonad/autostart` to `~/.xmonad/autostart`.

# 7) Install XMonad Configuration and XMobar
## a) Download XMonad Config
Download `.xmonad/xmonad.hs` and copy to `~/.xmonad/xmonad.hs` locally.
## b) Install XMobar
- Search [Releases](http://projects.haskell.org/xmobar/releases.html)
- Find latest deb file here: https://pkgs.org/search/xmobar
- Install deb file by using
```shell
sudo apt-get install libiw20
sudo dpkg -i xmobar_x.xx.x-x_amd64.deb
```
## c) Install XMobar Config
Downlaod .xmobarrc and copy to `~/.xmobarrc` locally.

# 8) Fix vi navigation
Create file `~/.vimrc` with content `set nocompatible`
