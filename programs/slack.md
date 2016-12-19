# Install Slack

We don't use the official way to install Slack, since we want auto update.

## a) Add Repo Key
> [Reference](https://packagecloud.io/app/slacktechnologies/slack/gpg#gpg-apt)

This requires [curl](utils/curl.md).
```shell
curl -L https://packagecloud.io/slacktechnologies/slack/gpgkey | sudo apt-key add -
```

## b) Create Repository Link
```shell
sudo sh -c 'echo "deb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" >> /etc/apt/sources.list.d/slack.list' 
```

## c) Install and Alias
Then run
```shell
sudo apt-get update
sudo apt-get install slack-desktop
```

And create the `.bash_aliases` entry:
```shell
alias chat='slack &> /dev/null &'
```
