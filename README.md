# StreamSpot Docker
<img src="http://www3.cs.stonybrook.edu/~emanzoor/streamspot/img/streamspot-logo.jpg" height="150" align="right"/>

[http://www3.cs.stonybrook.edu/~emanzoor/streamspot/](http://www3.cs.stonybrook.edu/~emanzoor/streamspot/)

## Build the Docker image

Requires credentials for `git.tc.bbn.com` stored as `$USER` and `$PASS`.

Build directly using Docker:
```
docker build --build-arg BBN_USER=$USER \
             --build-arg BBN_PASS=$PASS \
              -t marple/streamspot \
              github.com/sbustreamspot/sbustreamspot-docker.git
```

Or build from source:
```
git clone https://github.com/sbustreamspot/sbustreamspot-docker.git
cd sbustreamspot-docker
docker build --build-arg BBN_USER=$USER \
             --build-arg BBN_PASS=$PASS \
              -t marple/streamspot .
```

## Run the Docker container

Start the Docker container with the initial command `/streamspot`.

Requirements:

   * Training data (assumed to be stored as `train.avro` in the current directory).
   * Environment variable `CHUNK_LENGTH`: the shingling chunk length for StreamSpot.
   * Environment variables `KAFKA_URL_IN`, `KAFKA_TOPIC_IN`, `KAFKA_GROUP`.
   * Environment variables `KAFKA_URL_OUT`, `KAFKA_TOPIC_OUT`.

`env.list` contains a sample of variables to connect to Kafka in tc-in-a-box.
A container can be run using these by:
```
docker run \
  -v $(pwd)/train.avro:/train.avro:ro \
  --net host \
  --env-file ./env.list \
  marple/streamspot \
  /streamspot
```

## Note if connecting to Kafka in tc-in-a-box

The following must be done inside the tc-in-a-box VM.

Uncomment and configure the following settings in
`/opt/kafka_2.11-0.9.0.0/config/server.properties`:
```
advertised.host.name=192.168.87.2
advertised.port=9092
```

Then restart Kafka and Zookeeper:
```
cd tc-salt-services
./salt.sh starc.stop
./salt.sh starc.start
```
