# Installing Chrome
> [Reference](http://askubuntu.com/questions/510056/how-to-install-google-chrome)

## Install
```shell
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update 
sudo apt-get install google-chrome-stable
```

## Configure Alias `chrome`:
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

## Misc / Extensions
* Dont forget to install [uBlock Origin](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm?hl=en)
* [Session Buddy](https://chrome.google.com/webstore/detail/session-buddy/edacconmaakjimmfgnblocblbcdcpbko?hl=en) is great for managing your tabs

### Transfere Config
```shell
(cd ~/.config && zip -r ~/google-chrome.zip google-chrome)
```
