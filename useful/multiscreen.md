# Configure Multi Screen Setup

## Taffybar

If you want to spawn taffybar on a different screen that is not your primary screen, you can edit `~/.config/taffybar/taffybar.hs` and set the Monitor Number `monitorNumber :: Int -- ^ The xinerama/xrandr monitor number to put the bar on (default: 0)
` ([Reference](https://github.com/travitch/taffybar/blob/master/src/System/Taffybar.hs#L164)).

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
