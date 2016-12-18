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

## c) Download this Config
```shell
wget https://github.com/simlu/xmonad/archive/master.zip
```

## d) Autstart XMonad
> Reference: https://linuxexpresso.wordpress.com/2010/10/03/startx-automatically-on-login-ubuntu/

```shell
cp /etc/skel/.profile .profile
```
Append the following to `.profile`
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

# 2) Configure Keyboard
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
## a) Install Package
Reference: https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1022525
```shell
sudo apt-get install open-vm-tools-desktop
```
## b) Configure Autostart
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
sudo apt-get install libiw30
sudo dpkg -i xmobar_x.xx.x-x_amd64.deb
```
## c) Install XMobar Config
Copy file `.xmobarrc` to local `~/.xmobarrc`

# 8) Fix vi navigation
Copy file `.vimrc` to local `~/.vimrc`

# 9) Improve Shell Highlighting
Copy file `.xsession` to local `~/.xsession`
and add the following to `.bash_aliases`:
```shell
alias ls='ls --color'
LS_COLORS='di=36:ex=92'
export LS_COLORS
```

# 10) Disable Screensave and Hiberante
Copy files `.xprofile` and `.xscreensaver` to local `~/.xprofile` and `~/.xscreensaver`

# 11) Configure Multi Screen Setup
Edit `.xprofile`

# 12) Install IntelliJ Idea
Install, Unzip and define in `.bash_aliases`:
```shell
alias idea='wmname LG3D && IDEA_JDK=/usr/lib/jvm/java-8-oracle ~/Program/IntellijIDEA/bin/idea.sh &> /dev/null &'
```

# 13) Install PyCharm
Install, Unzip and define in `.bash_aliases`:
```shell
alias pycharm='wmname LG3D && PYCHARM_JDK=/usr/lib/jvm/java-8-oracle ~/Program/PyCharm/bin/pycharm.sh &> /dev/null &'
```
