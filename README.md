# Leanote

This is a docker container for the [Leanote](https://github.com/leanote/leanote) web application.

## Prerequisites

### Mongo Database

In order to use this container, you must first start a [Mongodb](https://hub.docker.com/_/mongo/) container.

Here is an example of starting a Mongodb container:

```
docker run --name mongo -v /my/own/datadir:/data/db -d mongo:3.2.3
```

### Populate the database

You can manually populate the database with the files found in the [Leanote repository](https://github.com/leanote/leanote/tree/master/mongodb_backup/leanote_install_data) but to assist in the population of the database, you can use the [furiousgeorge/leanote-populatedb](https://hub.docker.com/r/furiousgeorge/leanote-populatedb/) container.

For more information, read the instructions for the container, but the quick, one-time command to populate the database is:

```
docker run --rm --link mongo:mongo furiousgeorge/leanote-populatedb
```

## Startup Instructions

### Download the config file

In order to configure this container properly, you will need to download the configuration file to your host machine.  The command to do this is:

```
wget https://github.com/leanote/leanote/raw/master/conf/app.conf
```

Open the config file in your editor and adjust the settings to meet your needs.  The main setting you will need to change is the ```db.host``` under ```#mongodb``` - set it so it looks like this:

```
# mongdb
db.host=mongo
```

### Run the container

Once you have a Mongodb running, the database is populated with data, and the configuration file is setup; start this container by running the following command:

```
docker run --name=leanote -d -v $PWD/app.conf:/src/leanote/conf/app.conf --link mongo:mongo -p 80:9000 furiousgeorge/leanote
```

In this example, port 9000 in the container is mapped to port 80 on your host.  Adjust this port if you are already using port 80.
