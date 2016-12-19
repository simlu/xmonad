# Install RescueTime

> [Reference](https://www.rescuetime.com/get_rescuetime)

## Install Browser Extension
Can be found [here](https://chrome.google.com/webstore/detail/rescuetime-for-chrome-chr/bdakmnplckeopfghnlpocafcepegjeap).

## Install Package
Install Dependencies
```shell
sudo apt-get install sqlite3 gtk2-engines-pixbuf libqt4-sql-sqlite
```

Install [Trayer](utils/trayer.md) (rescuetime unfortunately requires a tray bar).

Download installer [here](https://www.rescuetime.com/setup/installer?os=amd64deb).

Then run 
```shell
sudo dpkg -i rescutime_curent_amd64.deb
```

## Configuration
Run
```shell
trayer
```
and then in a separate shell run
```shell
rescuetime
```
and enter email and password.

## Misc
* To check on status click the status icon in trayer.
* Note that you can also close trayer once rescuetime is running.

## Configure Autostart
Add the following to `~/.xmonad/autostart`. Note that [Trayer](utils/trayer.md) is required.
```shell
# start rescuetime
if [ -z "$(pgrep -x rescuetime)" ] ; then
    if [ -z "$(pgrep -x trayer)" ] ; then
        (cd /home/vinc; trayer &> /dev/null &);
    fi;
    sleep 2 && (cd /home/vinc; rescuetime &> /dev/null &) && sleep 10;
    kill $(pgrep -x trayer);
fi
```
