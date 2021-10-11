# Install Git
```
sudo apt install software-properties-common
sudo apt update
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git
```

# Remember login permanently

> **Important**: Credentials are stored in clear text in `.git-credentials` in home directory

```sh
git config --global credential.helper store
```
