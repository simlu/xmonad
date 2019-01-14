# Install Java 11 JDK
> [Reference](https://stackoverflow.com/questions/52504825/how-to-install-jdk-11-under-ubuntu)

Requires [apt-get-repository](apt-get-repository.md).

Add Repo, Install and Set Env Variables
```shell
sudo add-apt-repository ppa:openjdk-r/ppa \
&& sudo apt-get update -q \
&& sudo apt install -y openjdk-11-jdk
```
