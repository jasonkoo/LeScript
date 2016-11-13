#! /bin/bash
#export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:/etc/hbase/conf/
inputdir=/flume/precision/devicetag/tags_solr
outputdir=/flume/precision/devicetag/tags_hbase
tableName=device
su - flume -c "export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:/etc/hbase/conf/; hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.applog.export.hbase.Driver -DinputPath=$inputdir -DoutputPath=$outputdir -DtableName=$tableName"

su - hdfs  -c "hadoop fs -chown -R hbase:hbase $outputdir"
hbase org.apache.hadoop.hbase.mapreduce.LoadIncrementalHFiles $outputdir $tableName
su - hdfs  -c "hadoop fs  -rm -r -skipTrash $outputdir"
