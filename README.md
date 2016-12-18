# 1) Ubuntu and Xmonad
> [Reference](http://askubuntu.com/questions/142061/can-i-completely-remove-gnome-and-leave-xmonad)

## a) Install MinimalCD version of Ubuntu
Find the latest [MinimalCD](https://help.ubuntu.com/community/Installation/MinimalCD) version for the Ubuntu you want to use, download and install with VMWare.

Important: Ensure you allocate enough virtual machine memory, so that a decent amount of swap space is allocated.

## b) Install XMonad
```shell
sudo apt-get update
sudo apt-get install xorg xinit
sudo apt-get install xmonad
```
Type `startx` to start xmonad.

# 2) Download Configuration Package
```shell
cd downloads
wget https://github.com/simlu/xmonad/archive/master.zip
sudo apt-get install unzip
unzip master.zip
rm master.zip
```

# 3) Install VMWare Tools
> [Reference](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1022525)

We are using the iso coming from VMWare as it includes the lastest VMWare Tools. Discussion can be found [here](http://superuser.com/questions/270112/open-vm-tools-vs-vmware-tools).
## a) Mount CD
* Add a CD Drive to the VM
* Use `Install VM Tools`

## b) Install VMWare
Download `config/.update-vm-tools` and run it with 
```shell
. .update-vm-tools
```
To confirm the installation worked correctly run
```shell
vmware-toolbox-cmd -v
```

## c) Configure Autostart
> [Reference](http://askubuntu.com/questions/777839/fresh-ubuntu-16-04-install-broken-vmware-tools#answer-777922)

To enable vm tools you need to run `/usr/bin/vmware-user-suid-wrapper`.

To enable this as autostart, copy `config/.xmonad/autostart` to `~/.xmonad/autostart`.

# 4) Install Chrome
> [Reference](http://askubuntu.com/questions/510056/how-to-install-google-chrome)
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

Change download directory to `downloads` in settings.

# 5) Install XMonad Configuration and XMobar
## a) Download XMonad Config
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

# 6) Autostart XMmonad
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

# 7) Compile Misc Configurations
## a) Fix vi Arrow Keys
Copy file `config/.vimrc` to local `~/.vimrc`
## b) Improve Shell Highlighting
Copy file `config/.xprofile` to local `~/.xprofile` (this also does some other things, see below)
and add the following to `~/.bash_aliases`:
```shell
alias ls='ls --color'
LS_COLORS='di=36:ex=92'
export LS_COLORS
```
## c) Disable Screensave and Hibernate
Copy files `config/.xprofile` and `config/.xscreensaver` to local `~/.xprofile` and `~/.xscreensaver`
