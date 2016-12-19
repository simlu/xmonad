# Install Google Drive Sync

## Add Repo Key
```shell
wget -qO - https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key | sudo apt-key add -
```

## Add Repo
```shell
sudo sh -c 'echo "deb http://apt.insynchq.com/ubuntu trusty non-free" >> /etc/apt/sources.list.d/insync.list' 
```

# Install
```shell
sudo apt-get update
sudo apt-get install insync
```
