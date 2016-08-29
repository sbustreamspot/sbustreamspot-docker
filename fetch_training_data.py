#!/usr/bin/env python

import argparse
from pykafka import KafkaClient
from pykafka.exceptions import OffsetOutOfRangeError, RequestTimedOut
from pykafka.common import OffsetType
import sys

parser = argparse.ArgumentParser()
parser.add_argument('--url', help='Kafka URL', required=True)
parser.add_argument('--group', help='Kafka consumer group', required=True) 
parser.add_argument('--topic', help='Kafka topic', required=True) 
parser.add_argument('--training-dir', help='Directory to write training data to', 
                    required=True) 
args = vars(parser.parse_args())

kafka_url = args['url']
kafka_group = args['group']
kafka_topic = args['topic']
output_dir = args['training_dir']

print 'Connecting to Kafka at:', kafka_url
client = KafkaClient(kafka_url)
topic = client.topics[kafka_topic]
consumer = topic.get_simple_consumer(
            consumer_group=kafka_group, auto_commit_enable=True,
            auto_commit_interval_ms=100, reset_offset_on_start=False,
            auto_offset_reset=OffsetType.EARLIEST,
            consumer_timeout_ms=1000, fetch_wait_max_ms=1000)

j = 0
with open(output_dir + '/train.avro', 'wb') as f:
    print 'Consuming topic:', kafka_topic,
    print 'as group:', kafka_group
    for trial_num in range(5):
        for kafka_message in consumer:
            f.write(kafka_message.value)
            j += 1
    print 'Done: no more records'

print 'Wrote', j, 'training records to', output_dir + '/train.avro'

print 'Please wait until consumer offsets are committed...'
consumer.stop()
