# Install Java 11 JDK
> [Reference](https://stackoverflow.com/questions/52504825/how-to-install-jdk-11-under-ubuntu)

Requires [apt-get-repository](apt-get-repository.md).

Add Repo, Install and Set Env Variables
```shell
sudo add-apt-repository ppa:openjdk-r/ppa \
&& sudo apt-get update -q \
&& sudo apt install -y openjdk-11-jdk default-jdk
```

## Configure $JAVA_HOME

> [Reference](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04)

Run

```sh
sudo update-alternatives --config java
```

to find jdk path. Remove `/bin/java` from the end.

Then edit `/etc/environment` and add the line

```sh
JAVA_HOME="FILL/IN/PATH/TO/JDK/HERE"
```
