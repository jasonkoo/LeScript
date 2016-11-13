#! /bin/bash
inputdir=/flume/precision/devicetag/pre-output
outputdir=/flume/precision/devicetag/fakepath
threshold=0.1
envType=online

su - flume -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.applog.export.mongo.Driver -DinputPath=$inputdir -DoutputPath=$outputdir -Dthreshold=$threshold -DenvType=$envType"


