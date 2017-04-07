# Install RescueTime

> [Reference](https://www.rescuetime.com/get_rescuetime)

## Install Browser Extension
Can be found [here](https://chrome.google.com/webstore/detail/rescuetime-for-chrome-chr/bdakmnplckeopfghnlpocafcepegjeap).

## Install Package
Install Dependencies
```shell
sudo apt-get install sqlite3 gtk2-engines-pixbuf libqt4-sql-sqlite
```

Download installer [here](https://www.rescuetime.com/setup/installer?os=amd64deb).

Then run 
```shell
sudo dpkg -i rescutime_current_amd64.deb
```

## Configuration
Run
```shell
rescuetime
```
and enter email and password.

## Misc
* To check on status click the status icon.
* Taffybar can be closed once rescuetime is running, but it needs to be running when rescuetime is started.

## Configure Autostart
Add the following to `~/.xmonad/autostart`.
```shell
# start rescuetime
if [ -z "$(pgrep -x rescuetime)" ] ; then
    (cd /home/vinc; rescuetime &> /dev/null &);
fi
```
