# Install RescueTime

> [Reference](https://www.rescuetime.com/get_rescuetime)

## Install Browser Extension
Can be found [here](https://chrome.google.com/webstore/detail/rescuetime-for-chrome-chr/bdakmnplckeopfghnlpocafcepegjeap).

## Install Software
Install Dependencies
```shell
sudo apt-get install sqlite3 gtk2-engines-pixbuf libqt4-sql-sqlite
```

Download installer [here](https://www.rescuetime.com/setup/installer?os=amd64deb).

Then run 
```shell
sudo dpkg -i rescutime_curent_amd64.deb
```

## Configuration
Run
```shell
rescuetime
```
and enter email and password.
