# Installing Chrome
> [Reference](https://linuxize.com/post/how-to-install-google-chrome-web-browser-on-ubuntu-20-04/)

## Install
```shell
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
```

## Configure Alias `chrome`:

> **Important**: Should already be present if you followed instructions

Add the following at the top of `~/.bashrc`:
```shell
# open in browser
function chrome () {
  /opt/google/chrome/google-chrome --enable-plugins "$*" &> /dev/null &
}

# --------------------------
# Beginning or Original File
# --------------------------
```

We are defining this in `~/.bashrc` and not in `~/.bash_aliases` so that we can open files using chrome.

E.g. you can run
```shell
chrome some_image.png
```
To open an image in the browser. This also works with urls.

## Prevent Crashes
This is currently untested, but might help:
https://askubuntu.com/questions/765974/chrome-freeze-very-frequently-with-ubuntu-16-04

## Misc / Extensions
* Dont forget to install [uBlock Origin](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm?hl=en)
* [Session Buddy](https://chrome.google.com/webstore/detail/session-buddy/edacconmaakjimmfgnblocblbcdcpbko?hl=en) is great for managing your tabs

### Transfere Config
```shell
(cd ~/.config && zip -r ~/google-chrome.zip google-chrome)
```
