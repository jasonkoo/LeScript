#! /bin/bash
inputdir=/user/root/dump
outputdir=/user/root/tmp
tableName=sdac_device

export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:/etc/hbase/conf/
hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.sdac.export.hbase.Driver -DinputPath=$inputdir -DoutputPath=$outputdir -DtableName=$tableName

su - hdfs  -c "hadoop fs -chown -R hbase:hbase $outputdir"
hbase org.apache.hadoop.hbase.mapreduce.LoadIncrementalHFiles $outputdir $tableName
su - hdfs  -c "hadoop fs  -rm -r -skipTrash $outputdir"
