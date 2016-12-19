# Install Postgresql and PostGIS

> [Reference](http://tecadmin.net/install-postgresql-server-on-ubuntu/)

## Add Repo Key
```shell
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
```

## Add Repo
```shell
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
```

## Install PostgreSQL
Change the version to the appropritate PostgreSQL version.
```shell
sudo apt-get update
sudo apt-get install postgresql-9.5 postgresql-contrib-9.5
sudo apt-get install libpq-dev
```

## Install PostGIS
```shell
sudo apt-get install -y postgresql-9.5-postgis-2.2
```

Version support information for PostGIS on [AWS RDS](https://aws.amazon.com/rds/postgresql/) can be found [here](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html).
