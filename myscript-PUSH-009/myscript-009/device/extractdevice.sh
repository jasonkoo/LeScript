#! /bin/bash
minUpdateTime=$(date -d "30 days ago" +"%Y%m%d 00:00:00")
part=$1
inputdir=/flume/$part/device
outputdir=/flume/$part/device_solr
numreducers=30

su - flume -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.device.extract.Driver -DinputPath=$inputdir -DoutputPath=$outputdir -DnumReducers=$numreducers -DminUpdateTime=$minUpdateTime"
