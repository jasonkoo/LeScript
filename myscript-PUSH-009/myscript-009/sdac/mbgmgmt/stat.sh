#! /bin/bash
mysqlIP=PUSH-011
mysqlPort=3306
mysqlUserName=lestat
mysqlPassword=lestat
mysqlDatabase=db_push_stats
mysqlTable=statresult

# daily stat
#themonth=$(date -d yesterday "+%Y%m")
#inputPaths=/flume/sdac/sdac/$themonth
#outputPathStage1=/user/lestat/stats/sdac/mgbmgmt/stage1
#outputPathStage2=/user/lestat/stats/sdac/mgbmgmt/stage2
#startTime=$(date -d yesterday +"%Y%m%d 00:00:00")
#endTime=$(date -d yesterday +"%Y%m%d 24:00:00")
#su - lestat -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar  com.lenovo.push.data.mr.sdac.mbgmgmt.Driver -D inputPaths=$inputPaths -D outputPathStage1=$outputPathStage1 -D outputPathStage2=$outputPathStage2 -D startTime='$startTime' -D endTime='$endTime' -D numReducers=10"
#sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $outputPathStage2 --update-key thekey,thedate  --update-mode allowinsert --input-fields-terminated-by '\001'

# quarterly stat
themonth=$(date -d yesterday "+%m")
endmonth=$(date -d yesterday "+%Y%m")
startmonth=$(( $endmonth - $themonth % 3  + 1 ))
inputPaths=""
for thismonth  in `./monthloop $startmonth $endmonth`
do
   inputPaths+="/flume/sdac/sdac/$thismonth,"
done
inputPaths=${inputPaths%?}
outputPathStage1=/user/lestat/stats/sdac/mgbmgmt/stage1
outputPathStage2=/user/lestat/stats/sdac/mgbmgmt/stage2
startTime=$startmonth"01 00:00:00"
endTime=$(date -d yesterday "+%Y%m%d 24:00:00")

su - lestat -c "hadoop jar /data/mapredjars/MRTreasury-0.0.1-SNAPSHOT.jar  com.lenovo.push.data.mr.sdac.mbgmgmt.Driver -D inputPaths=$inputPaths -D outputPathStage1=$outputPathStage1 -D outputPathStage2=$outputPathStage2 -D startTime='$startTime' -D endTime='$endTime' -D numReducers=10"
sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $outputPathStage2 --update-key thekey,thedate  --update-mode allowinsert --input-fields-terminated-by '\001'

