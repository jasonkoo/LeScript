#! /bin/bash
thedate=$(date -d "1 days ago" +%Y%m%d)
inputdir=/flume/precision/applogs_orig/$thedate
outputdir=/flume/precision/applogs_merged/latest
su - flume -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.applog.parse.Driver -D inputPath=$inputdir -D outputPath=$outputdir -D numReducers=20"

# sudo not working, require tty
#sudo -u flume hadoop jar /data/precision/App22Tag.jar applog.transform.Driver -D inputPath=$inputdir -D outputPath=$outputdir


