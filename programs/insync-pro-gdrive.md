# Install InSync for Google Drive

> [Reference](https://ubuntuhirek.wordpress.com/2012/11/19/install-insync-unofficial-google-docsdriver-client-on-ubuntu-via-repository/)

## Add Repo Key
```shell
wget -qO - https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key | sudo apt-key add -
```

## Add Repo
```shell
sudo sh -c 'echo "deb http://apt.insynchq.com/ubuntu trusty non-free" >> /etc/apt/sources.list.d/insync.list' 
```

## Install
```shell
sudo apt-get update
sudo apt-get install insync
```

## Display in Xmobar
Add the following to `~/.xmobarrc` under `commands`:
```haskell 
, Run Com "insync" ["get_sync_progress"] "insync" 50
```
And then reference it below in `template` as
```haskell
| <fc=lightblue>%insync%</fc> 
```
Then run
```shell
xmonad --recompile && xmonad --restart
```
