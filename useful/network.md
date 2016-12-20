# Network

If you have network issues run:
```shell
ifconfig -a
```
to list all your network adapters.
Then run 
```shell
sudo vi /etc/network/interfaces
```

and make sure the interfaces are reflected there.

Finally restart your network by running
```shell
sudo /etc/init.d/networking restart
```

## Misc
* Try restarting your host
