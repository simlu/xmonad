# Install keepass

> [Reference](http://www.howtogeek.com/93798/install-keepass-password-safe-on-your-ubuntu-or-debian-based-linux-system/)

Requires [apt-get-repository](utils/apt-get-repository.md).

## Add Repo
```shell
sudo apt-add-repository ppa:jtaylor/keepass
sudo apt-get update
```

## Install
```shell
sudo apt-get install keepass2
```

## Alias
Add the following to `~/.bash_aliases`:
```shell
alias keepass='/usr/bin/keepass2 &> /dev/null &'
```

## Misc
### Transfere Config
```shell
(cd ~/.config/KeePass && zip -r ~/KeePass.zip .)
```
