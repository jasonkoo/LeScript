#! /bin/bash
envType=zuk
part=zuk
thedate=$(date -d "1 days ago" +%Y%m%d)
inputPath=/flume/$part/feedback/$thedate
stage1OutputPath=/user/lestat/stats/$part/pushmarketing/feedback/dimstat/stage1
stage2OutputPath=/user/lestat/stats/$part/pushmarketing/feedback/dimstat/stage2
stage3BaseOutputPath=/user/lestat/stats/$part/pushmarketing/feedback/dimstat/stage3/$thedate
numReducers=6

dbip=10.0.76.200
hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar  com.lenovo.push.data.mr.feedback.Driver -DinputPath=$inputPath -Dstage1OutputPath=$stage1OutputPath -Dstage2OutputPath=$stage2OutputPath -Dstage3BaseOutputPath=$stage3BaseOutputPath -DnumReducers=$numReducers -Dthedate=$thedate -DenvType=$envType

for dim in devicemodel cityname peversion
do
    sqoop-export --connect jdbc:mysql://$dbip:3306/db_lestat --username lestat --password lestat --table feedback_$dim --export-dir $stage3BaseOutputPath/$dim --update-key adid,$dim,thedate  --update-mode allowinsert --input-fields-terminated-by '\001'
done
