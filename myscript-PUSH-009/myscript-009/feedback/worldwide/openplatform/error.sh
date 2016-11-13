#! /bin/bash
thedate=$(date -d '1 days ago' +%Y%m%d)

hiveDatabase=worldwide
hiveTable=feedback

hdfsDir=/user/lestat/stats/$hiveDatabase/openplatform/error/$thedate
prefix='openplatform.error'

mysqlIP=PUSH-011
mysqlPort=3306
mysqlUserName=lestat
mysqlPassword=lestat
mysqlDatabase=db_push_stats
mysqlTable=statresult

inserttime=$(date "+%Y-%m-%d %T")

hive -e \
"use $hiveDatabase; \
INSERT OVERWRITE Directory '$hdfsDir' select concat('$prefix', '.', feedbackId, '.', eventName) as thekey, thedate, count(distinct pid) as value, '$inserttime' as lmt from $hiveTable where thedate='$thedate' and sid!='rwthr01' and feedbackid like concat(sid, '_%') and success=false group by feedbackId, eventName, thedate;"

sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --update-key thekey,thedate  --update-mode allowinsert --input-fields-terminated-by '\001'
