# Configure Multi Screen Setup

## VMWare
VMWare seems to work fine without any custom configuration.

## VirtualBox
* run `xrandr`
* identify the monitors
* run `xrandr --output VBOX1 --auto --left-of VBOX2` for the different monitors until the alignment is correct

To do this automatically edit `~/.xprofile` and paste commands in there (they will be run on each startup)

### Example
```shell
# set up screen alignment
xrandr --output VGA-0 --auto --left-of VGA-2
xrandr --output VGA-1 --auto --left-of VGA-0
```

## Harware
- tbd
