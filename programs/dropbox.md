# Install Dropbox

> [Reference](www.ubuntuupdates.org/ppa/dropbox)

Add key with
```shell
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
```
Then add repo with
```shell
sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ xenial main" >> /etc/apt/sources.list.d/dropbox.list' 
```

Then run
```shell
sudo apt-get update
sudo apt-get install dropbox
```
