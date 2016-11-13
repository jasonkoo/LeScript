nohup bin/kafka-server-start.sh config/server.properties > sv.out &

bin/kafka-topics.sh --create --zookeeper PUSH-010:2181,PUSH-012:2181,PUSH-018:2181 --replication-factor 2 --partitions 24 --topic appinfo-topic

bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic feedback-topic

bin/kafka-topics.sh --list --zookeeper localhost:2181

bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic appinfo-topic

bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic appfeedback-topic --from-beginning > bbb.txt

bin/kafka-console-producer.sh --broker-list  PUSH-010:9092,PUSH-018:9092 --topic feedback

