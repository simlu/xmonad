# Configure Multi Screen Setup

## Xmobar

If you want to spawn xmobar a different screen that is not your primary screen, you can edit `~/.xmonad/xmonad.hs` and change `"xmobar"` to `"xmobar -x 1"` where `1` is your second screen (`0` is default).

## VMWare
VMWare seems to work fine without any custom configuration.

## VirtualBox
VirtualBox seems to work fine without any custom configuration. You might need to move the screen around until they align correctly. You can test this by dragging frames with `ctrl`.

## Hardware

### Identify Monitors
```shell
xrandr
```
### Align Monitors
Run the following for the different monitors until the alignment is correct:
```shell
xrandr --output VBOX1 --auto --left-of VBOX2
```
### Automation
Write the commands as found above into `~/.xprofile`. They will be run on each startup.

#### Example
```shell
# set up screen alignment
xrandr --output VGA-0 --auto --left-of VGA-2
xrandr --output VGA-1 --auto --left-of VGA-0
```
