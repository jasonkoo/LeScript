#! /bin/bash
inputdir=/flume/precision/devicetag/pre-output
outputdir=/flume/precision/devicetag/tags_solr
threshold=0.1
su - flume -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.applog.extract.Driver -DinputPath=$inputdir -DoutputPath=$outputdir -Dthreshold=$threshold"     
