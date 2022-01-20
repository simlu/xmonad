# Installing PGAdmin

(Requires Docker)

```sh
mkdir ~/.pgadmin4  # to store config and stuff
docker run --rm --network host -v ~/.pgadmin4:/pgadmin thajeztah/pgadmin4
```

To bash aliases add

`alias pgadmin='docker run --rm --network host -v ~/.pgadmin4:/pgadmin thajeztah/pgadmin4'`

Then go to http://localhost:5050

- [Reference](https://stackoverflow.com/questions/41260004/error-trying-to-run-pgadmin4#answer-51593274)
