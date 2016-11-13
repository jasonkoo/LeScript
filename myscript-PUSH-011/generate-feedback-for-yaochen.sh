#! /bin/bash
starttime=$(date +%s)
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Start generating feedback for chengdu yaochen precision at $(date)"
startdate=$(date -d '7 days ago' +%Y%m%d)
echo "start date: $startdate"
enddate=$(date +%Y%m%d)
echo "end date: $enddate"

#sudo -u lestat hive -S -e \
hive -e \
"ADD JAR /home/lestat/jar/lestat-hive-0.0.1-SNAPSHOT.jar; \
insert overwrite directory '/user/root/dump'
select deviceid, logtime, adid, eventtype, netaccesstype, ip, operatorcode, chargestatus, cityname, countrycode, devicemodel from db_lestat.feedback where thedate>='$startdate' and thedate<='$enddate';"  

hadoop fs -getmerge /user/root/dump /data/ftp/yaochen/feedback/push-feedback.$enddate

echo "End generating feedback for chengdu yaochen precision at $(date)"

endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
