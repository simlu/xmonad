# ffmpeg (Screen Recording)

## Install
```shell
sudo apt-get install ffmpeg
```

## Record Screen
Add to .bashrc
```shell
# record screen
function record () {
  ffmpeg -follow_mouse 100 -f x11grab -framerate 25 -r 100 -s 600x480 -i :0.0 -b 3000k $1
}
```

Run with

```shell
record file.mpg
```
