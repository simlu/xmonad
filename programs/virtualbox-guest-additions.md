# Install VirtualBox Guest Additions

> [Reference](http://www.htpcbeginner.com/install-virtualbox-guest-additions-on-ubuntu-debian/)

## Install Dependencies
```shell
sudo apt-get install dkms
```

## Mount CD
* Add a CD Drive to the VM
* Click `Devices > Insert Guest Additions CD image...`

## Install
Download [scripts/update-vb-guest-additons.sh](/scripts/update-vb-guest-additons.sh) and run it with
```shell
sudo bash update-vb-guest-additons.sh
```
and restart.
