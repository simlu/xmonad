# Install Dropbox

> [Reference](www.ubuntuupdates.org/ppa/dropbox)

## a) Install Dependencies
```shell
sudo apt-get install libxslt1.1
```

## b) Add Repo Key
```shell
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
```

## c) Add repo
```shell
sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ xenial main" >> /etc/apt/sources.list.d/dropbox.list' 
```

## d) Install
```shell
sudo apt-get update
sudo apt-get install dropbox
```

## e) Setup
```shell
/usr/bin/dropbox start -i
```
To check the status run
```shell
/usr/bin/dropbox status
```
