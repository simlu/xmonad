
# JetBrains IDE

Requires [Java](utils/java.md).

## Install wmname
```shell
sudo apt install suckless-tools
```

## Settings
Can be found in `~/.<PRODUCT><VERSION>` ([Reference](https://intellij-support.jetbrains.com/hc/en-us/articles/206544519-Directories-used-by-the-IDE-to-store-settings-caches-plugins-and-logs)). E.g. to save PyCharm Settings run
```shell
zip -r ~/tmp-pycharm.zip .PyCharm2016.2
```

## Install

### IntelliJ Idea
Install, Unzip and define in `.bash_aliases`:
```shell
alias idea='wmname LG3D && IDEA_JDK=/usr/lib/jvm/java-8-oracle ~/Programs/idea/bin/idea.sh &> /dev/null &'
```

### PyCharm
Install, Unzip and define in `.bash_aliases`:
```shell
alias pycharm='wmname LG3D && PYCHARM_JDK=/usr/lib/jvm/java-8-oracle ~/Programs/pycharm/bin/pycharm.sh &> /dev/null &'
```

### WebStorm
Install, Unzip and define in `.bash_aliases`:
```shell
alias webstorm='wmname LG3D && WEBSTORM_JDK=/usr/lib/jvm/java-8-oracle ~/Programs/webstorm/bin/webstorm.sh &> /dev/null &'
```
