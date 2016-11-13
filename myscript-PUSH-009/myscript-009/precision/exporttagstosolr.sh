#! /bin/bash
echo "#Step 2. Export users' tags to Solr"
starttime=$(date +%s)
echo "Start exporting users' tags at $(date)"

inputdir=/flume/precision/devicetag/pre-output
outputdir=/flume/precision/devicetag/fakepath
threshold=0.1
topicName=susfb-topic
 
su - flume -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.tagstosolr.Driver -DinputPath=$inputdir -DoutputPath=$outputdir -Dthreshold=$threshold -DtopicName=$topicName"     

echo "End exporting users' tags at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
DIFFHOUR=$(( ($endtime - $starttime) / 3600 ))
echo "It took $DIFF seconds"
echo "It took $DIFFHOUR hours"
echo


