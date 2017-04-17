
# Install xclip

`sudo apt-get install xclip`

# Edit `.bashrc`

```shell
# copy file to clipboard
function copy () {
  cat "$*" | xclip -i
}
```
