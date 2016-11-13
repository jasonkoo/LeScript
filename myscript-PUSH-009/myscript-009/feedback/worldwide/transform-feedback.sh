#! /bin/bash
startdate='20151013'
enddate='20151013'
for thedate in `./dateloop $startdate $enddate`
do
  inputdir=/flume/worldwide/feedbackx/$thedate
  outputdir=/flume/worldwide/feedbacknew/$thedate
  su - flume -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar com.lenovo.push.data.mr.feedback.transform.Driver -DinputPath=$inputdir -DoutputPath=$outputdir"
done
