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

# 4) Install Java 8
Reference: http://tipsonubuntu.com/2016/07/31/install-oracle-java-8-9-ubuntu-16-04-linux-mint-18/
```shell
sudo add-apt-repository ppa:webupd8team/java
sudo apt update
sudo apt install oracle-java8-installer
javac -version
sudo apt install oracle-java8-set-default
```
