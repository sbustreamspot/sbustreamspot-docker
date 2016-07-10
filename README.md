# StreamSpot Docker
<img src="http://www3.cs.stonybrook.edu/~emanzoor/streamspot/img/streamspot-logo.jpg" height="150" align="right"/>

[http://www3.cs.stonybrook.edu/~emanzoor/streamspot/](http://www3.cs.stonybrook.edu/~emanzoor/streamspot/)

## Build the Docker image

Requires credentials for `git.tc.bbn.com` stored as `$USER` and `$PASS`.

Build directly using Docker:
```
docker build -t marple/sbustreamspot github.com/sbustreamspot/sbustreamspot-docker.git
```

Or build from source:
```
git clone https://github.com/sbustreamspot/sbustreamspot-docker.git
cd sbustreamspot-docker
docker build --build-arg BBN_USER=$USER --build-arg BBN_PASS=$PASS -t streamspot .
```

## Run the Docker container

Requires a CDM13/Avro file with training data stored in the current directory as `train.avro`.
```
TODO
```
