#! /bin/bash
inputdir="/user/root/sdac/monthdate_added"
outputdir="/user/root/sdac/cc_firsttime_added"
numReducers=400
hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.sdac.clean.Driver -D inputPath=$inputdir -D outputPath=$outputdir -D numReducers=$numReducers

