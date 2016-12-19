# Installing Chrome
> [Reference](http://askubuntu.com/questions/510056/how-to-install-google-chrome)

```shell
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update 
sudo apt-get install google-chrome-stable
```
Then configure the alias `chrome`:
```shell
vi .bash_aliases
```
Then add:
```shell
alias chrome='/opt/google/chrome/google-chrome --enable-plugins &> /dev/null &'
```

## Define Quick Show
To view any file in Chrome, add the following at the top of `~/.bashrc`:
```shell
# open in browser
function show () {
  google-chrome "$*" &> /dev/null &
}

# --------------------------
# Beginning or Original File
# --------------------------
```

## Misc
* Dont forget to install [Adblock Plus](https://chrome.google.com/webstore/detail/adblock-plus/cfhdojbkjhnklbpkdaibdccddilifddb).
