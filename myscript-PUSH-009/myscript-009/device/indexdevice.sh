#! /bin/bash
part=$1
colname="device_$part"
mid="device_${part}_batch"
solrctl collection --deletedocs $colname
su - hdfs  -c "hadoop jar /data/cloudera/parcels/CDH-5.2.1-1.cdh5.2.1.p0.12/jars/search-mr-1.0.0-cdh5.2.1-job.jar org.apache.solr.hadoop.MapReduceIndexerTool --morphline-file /data/mapredjars/device-batch-morphline.conf --morphline-id $mid --output-dir hdfs://PUSH-007:8020/flume/$part/device_tags_indexed --zk-host PUSH-013:2181,PUSH-012:2181,PUSH-018:2181,PUSH-010:2181,PUSH-011:2181/solr --collection $colname --go-live hdfs://PUSH-007:8020/flume/$part/device_tags"
