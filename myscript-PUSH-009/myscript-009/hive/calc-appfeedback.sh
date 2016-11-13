#! /bin/bash
#cd /data/lestat/lestat-0.0.1-SNAPSHOT/bin/
#./hivetask.sh
#- mysql database  connection parameters
dbip=PUSH-011
dbport=3306
dbname=db_aomp
username=lestat
password=lestat
tablename=appfeedback

echo "------------------------------------------------------------------------------------------------------------------------------------------------------"
starttime=$(date +%s)
echo "Start calculating appfeedback for each adid of each sid at $(date)"
thedate=$(date -d '1 days ago' +%Y%m%d)
echo "thedate: $thedate"
inserttime=$(date "+%Y-%m-%d %T")

hive -e \
"use aomp; \
INSERT OVERWRITE Directory '/user/lestat/data/appfeedback' select sid, adid, thedate, eventtype, count(distinct deviceid) as value, '$inserttime' as lmt from appfeedback where thedate = '$thedate' and length(sid) > 1 and !(sid RLIKE '^r.+') and adid like concat(sid, '_%') group by sid, adid, thedate, eventtype;"

sqoop-export --connect jdbc:mysql://$dbip:$dbport/$dbname --username $username --password $password --table $tablename --export-dir /user/lestat/data/appfeedback --update-key sid,adid,thedate,eventtype  --update-mode allowinsert --input-fields-terminated-by '\001'

echo "End calculating appfeedback for each adid of each sid  at $(date)"

endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
