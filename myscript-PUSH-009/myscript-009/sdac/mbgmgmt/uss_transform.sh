#! /bin/bash
inputdir="/flume/sdac/uss_orig"
outputdir="/flume/sdac/uss"
su - flume -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.uss.Driver -D inputPath=$inputdir -D outputPath=$outputdir"

