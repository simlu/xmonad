## Install

Follow instructions here:

https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository

Then, add yourself to the docker group so you can use docker without sudo:

```
sudo groupadd docker
sudo gpasswd -a $USER docker
```

Then, you need to reboot, because group membership is somehow cached on linux.

## Cleanup Temporary Docker Data

    $ docker rm $(docker ps -a -q)

    $ docker rmi $(docker images -q)

To also force kill running docker containers use

    $ docker rm $(docker ps -a -q) --force

    $ docker rmi $(docker images -q) --force

And finally run

    $ docker volume rm $(docker volume ls -qf dangling=true)

    $ docker system prune -a
