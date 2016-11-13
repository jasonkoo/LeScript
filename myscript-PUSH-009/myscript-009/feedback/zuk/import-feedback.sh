#! /bin/bash
part=zuk
envType=online
thedate=$(date -d "1 days ago" +%Y%m%d)
inputdir=/flume/$part/feedback/$thedate
outputdir=/flume/$part/feedbackx/$thedate

su - flume -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.feedback.importx.Driver -DenvType=$envType -Dpart=$part -DinputPath=$inputdir -DoutputPath=$outputdir"
