#! /bin/bash
inputdir=/flume/precision/deviceappssnapshot
modeldir=/flume/precision/app2tag 
tempdir=/flume/precision/devicetag/temp
outputdir=/flume/precision/devicetag/pre-output
output2dir=/flume/precision/devicetag/output2
numreducers=40

su - flume -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.applog.tag.UserWeightDriverPriest -D input=$inputdir -D model=$modeldir -D temp=$tempdir -D output=$outputdir -D output2=$output2dir -D numReducers=$numreducers"
