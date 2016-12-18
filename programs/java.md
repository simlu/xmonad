# 8) Install Java 8
## a) Add `apt-get-repository` command
Reference: http://askubuntu.com/questions/493460/how-to-install-add-apt-repository-using-the-terminal
```shell
sudo apt-get install software-properties-common
```
## b) Add Repo, Install and Set Env Variables
Reference: http://tecadmin.net/install-oracle-java-8-jdk-8-ubuntu-via-ppa/#
```shell
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
java -version
sudo apt-get install oracle-java8-set-default
```
