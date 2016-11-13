#! /bin/bash
twoDaysAgo=$(date -d "2 days ago" +%Y%m%d)
oneDayAgo=$(date -d "1 days ago" +%Y%m%d)
inputdirs="/flume/precision/applogs_merged/latest,/flume/precision/applogs_merged/$twoDaysAgo"
outputdir="/flume/precision/applogs_merged/$oneDayAgo"
snapshotdir="/flume/precision/deviceappssnapshot"
su - flume -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.applog.merge.Driver -D inputPaths=$inputdirs -D outputPath=$outputdir -D numReducers=48"

su - flume -c "hadoop fs -rm -r -f -skipTrash $snapshotdir/*"
su - flume -c "hadoop fs -cp $outputdir/* $snapshotdir"

# sudo not working, require tty
#sudo -u flume hadoop jar /data/precision/App22Tag.jar applog.transform.Driver -D inputPath=$inputdir -D outputPath=$outputdir


