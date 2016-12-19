# Install Slack

We don't use the official way to install Slack, since we want auto update.

Create Repository Link
```shell
sudo sh -c 'echo "deb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" >> /etc/apt/sources.list.d/slack.list' 
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
