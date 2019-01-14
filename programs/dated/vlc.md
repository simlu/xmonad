# Install VLC

> [Reference](http://www.howopensource.com/2012/10/install-vlc-in-ubuntu-12-10-12-04/)

```shell
sudo apt-get install vlc
```
Add to `.bashrc`:
```shell
# open file with vlc
function vlc () {
  /usr/bin/vlc $1 &> /dev/null &
}
```
