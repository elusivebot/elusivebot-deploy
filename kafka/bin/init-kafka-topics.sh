#!/bin/sh

KT="/opt/bitnami/kafka/bin/kafka-topics.sh"

echo "Waiting for kafka..."
"$KT" --bootstrap-server localhost:9092 --list

echo "Creating kafka topics"
"$KT" --bootstrap-server localhost:9092 --create --if-not-exists --topic messages-input --replication-factor 1 --partitions 1
"$KT" --bootstrap-server localhost:9092 --create --if-not-exists --topic messages-output --replication-factor 1 --partitions 1
"$KT" --bootstrap-server localhost:9092 --create --if-not-exists --topic http-input --replication-factor 1 --partitions 1
"$KT" --bootstrap-server localhost:9092 --create --if-not-exists --topic http-output --replication-factor 1 --partitions 1
"$KT" --bootstrap-server localhost:9092 --create --if-not-exists --topic discord-input --replication-factor 1 --partitions 1
"$KT" --bootstrap-server localhost:9092 --create --if-not-exists --topic discord-output --replication-factor 1 --partitions 1
"$KT" --bootstrap-server localhost:9092 --create --if-not-exists --topic direct-input --replication-factor 1 --partitions 1
"$KT" --bootstrap-server localhost:9092 --create --if-not-exists --topic direct-output --replication-factor 1 --partitions 1

echo "Successfully created the following topics:"
"$KT" --bootstrap-server localhost:9092 --list

