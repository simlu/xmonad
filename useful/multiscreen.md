# Configure Multi Screen Setup

## VMWare
VMWare seems to work fine without any custom configuration.

## VirtualBox
VirtualBox seems to work fine without any custom configuration. You might need to move the screen around until they align correctly. You can test this by dragging frames with `ctrl`.

## Harware

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
