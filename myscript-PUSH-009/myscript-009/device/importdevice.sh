#! /bin/bash
thedate=$(date -d "1 days ago" +%Y%m%d)
envType=online
#export envType
part=$1
inputdir=/flume/$part/uv/$thedate
outputdir=/flume/$part/device_merged/latest
numreducers=50

su - flume -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.device.importx.Driver -DenvType=$envType -Dpart=$part -DinputPath=$inputdir -DoutputPath=$outputdir -DnumReducers=$numreducers"
