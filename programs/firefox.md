# Installing Firefox
> [Reference](http://www.webupd8.org/2011/05/install-firefox-nightly-from-ubuntu-ppa.html)

## Install
```shell
sudo add-apt-repository ppa:ubuntu-mozilla-daily/ppa
sudo apt-get update
sudo apt-get install firefox-trunk 
```

## Configure Alias `firefox`:
[Reference](https://www.cyberciti.biz/faq/howto-run-firefox-from-the-command-line/)

Add the following at the top of `~/.bashrc`:
```shell
# open in firefox
function firefox () {
  /usr/bin/firefox-trunk -new-window -search "$*" &> /dev/null &
}


# --------------------------
# Beginning or Original File
# --------------------------
```

## Misc / Extensions
* Dont forget to install [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
