# Install Dropbox

> [Reference](www.ubuntuupdates.org/ppa/dropbox)

## Install Dependencies
```shell
sudo apt-get install libxslt1.1
```

## Add Repo Key
```shell
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
```

## Add repo
```shell
sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ xenial main" >> /etc/apt/sources.list.d/dropbox.list' 
```

## Install
```shell
sudo apt-get update
sudo apt-get install dropbox
```

## Setup
```shell
/usr/bin/dropbox start -i
```
To check the status run
```shell
/usr/bin/dropbox status
```

## Autostart
Edit `~/.xmonad/autostart` and add the lines
```shell
# start dropbox
/usr/bin/dropbox start
```

## Display in Xmobar
Add the following to `~/.xmobarrc` under `commands`:
```haskell 
, Run Com "dropbox" ["status"] "dropbox" 50
```
And then reference it below in `template` as
```haskell
| <fc=lightblue>%dropbox%</fc>
```
Then run
```shell
xmonad --recompile && xmonad --restart
```

## Misc
* Modify sync speed by using
```shell
dropbox throttle unlimited unlimited
```
