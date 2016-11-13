#! /bin/bash
twoDaysAgo=$(date -d "2 days ago" +%Y%m%d)
oneDayAgo=$(date -d "1 days ago" +%Y%m%d)
part=$1
inputdirs="/flume/$part/device_merged/latest,/flume/$part/device_merged/$twoDaysAgo"
#inputdirs="/flume/$part/device_merged/latest"
outputdir="/flume/$part/device_merged/$oneDayAgo"
snapshotdir="/flume/$part/device"
su - flume -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.device.merge.Driver -DinputPaths=$inputdirs -DoutputPath=$outputdir -DnumReducers=48"

su - flume -c "hadoop fs -rm -r -f -skipTrash $snapshotdir/*"
su - flume -c "hadoop fs -cp $outputdir/* $snapshotdir"

# sudo not working, require tty
#sudo -u flume hadoop jar /data/precision/App22Tag.jar applog.transform.Driver -D inputPath=$inputdir -D outputPath=$outputdir


