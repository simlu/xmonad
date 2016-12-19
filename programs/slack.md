# Install Slack

We don't use the official way to install Slack, since we want auto update.

Create file
```shell
sudo vi /etc/apt/sources.list.d/slack.list
```
and add the content
```
### THIS FILE IS AUTOMATICALLY CONFIGURED ###
# You may comment out this entry, but any other modifications may be lost.
deb https://packagecloud.io/slacktechnologies/slack/debian/ stretch main
```

Then run
```shell
sudo apt-get update
sudo apt-get install slack-desktop
```

And create the `.bash_aliases` entry:
```shell
alias chat='slack &> /dev/null &'
```
