
# JetBrains IDE

Requires [Java](utils/java.md).

## a) Install wmname
```shell
sudo apt install suckless-tools
```

## b) Install IntelliJ Idea
Install, Unzip and define in `.bash_aliases`:
```shell
alias idea='wmname LG3D && IDEA_JDK=/usr/lib/jvm/java-8-oracle ~/Programs/idea/bin/idea.sh &> /dev/null &'
```

## c) Install PyCharm
Install, Unzip and define in `.bash_aliases`:
```shell
alias pycharm='wmname LG3D && PYCHARM_JDK=/usr/lib/jvm/java-8-oracle ~/Programs/pycharm/bin/pycharm.sh &> /dev/null &'
```

## d) Install WebStorm
Install, Unzip and define in `.bash_aliases`:
```shell
alias webstorm='wmname LG3D && WEBSTORM_JDK=/usr/lib/jvm/java-8-oracle ~/Programs/webstorm/bin/webstorm.sh &> /dev/null &'
```
