#! /bin/bash
part=$1
inputdirs="/flume/$part/device_solr,/flume/precision/devicetag/tags_solr"
outputdir="/flume/$part/device_tags"
su - flume -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.device.join.Driver -DinputPaths=$inputdirs -DoutputPath=$outputdir -DnumReducers=30"
