#! /bin/bash

#- mysql database  connection parameters
dbip=PUSH-011
dbport=3306
dbname=db_aomp
username=lestat
password=lestat
tablename=appdevicemodel

echo "------------------------------------------------------------------------------------------------------------------------------------------------------"
starttime=$(date +%s)
echo "Start calculating the number of active users for each device model of each application at $(date)"
startdate=$(date -d '15 days ago' +%Y%m%d)
echo "start date: $startdate"
enddate=$(date -d '0 days ago' +%Y%m%d)
echo "end date: $enddate"
inserttime=$(date "+%Y-%m-%d %T")

hive -e \
"ADD JAR /home/lestat/jar/lestat-hive-0.0.1-SNAPSHOT.jar;\
CREATE TEMPORARY FUNCTION sha1 as 'com.lenovo.push.marketing.hive.udf.Sha1'; \
use aomp; \
INSERT OVERWRITE Directory '/user/lestat/data/appdevicemodel' select sha1(concat(sid, deviceModel)) as sha1, sid, deviceModel, count(distinct deviceid) as actnum, '$inserttime' as lmt from appinfo where thedate >= '$startdate' and thedate <= '$enddate' and appvername != 'unknown' and length(sid) > 1  and  length(sid) < 50 and !(sid RLIKE '^r.+') group by sid, deviceModel;"

sqoop-export --connect jdbc:mysql://$dbip:$dbport/$dbname --username $username --password $password --table $tablename --export-dir /user/lestat/data/appdevicemodel --update-key sha1  --update-mode allowinsert --input-fields-terminated-by '\001'

echo "End calculating the number of active users for each device model of each application at $(date)"

endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
