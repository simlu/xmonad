# Install Dropbox

> [Reference](www.ubuntuupdates.org/ppa/dropbox)

## a) Add Repo Key
```shell
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
```

## b) Add repo
```shell
sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ xenial main" >> /etc/apt/sources.list.d/dropbox.list' 
```

## c) Install
```shell
sudo apt-get update
sudo apt-get install dropbox
```

## d) Setup
```shell
/usr/bin/dropbox start
```
