```sh
curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

rmdir ~/.npmrc

vi ~/.npmrc
```
add
```
//registry.npmjs.org/:_authToken=TOKEN_HERE
```
