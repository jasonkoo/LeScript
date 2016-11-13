#! /bin/bash
thedate=$(date -d '1 days ago' +%Y%m%d)

hiveDatabase=zuk
hiveTable=feedback

hdfsDir=/user/lestat/stats/$hiveDatabase/pushmarketing/feedback/$thedate
keyPrefix='pushmarketing.feedback'

mysqlIP=10.0.76.200
mysqlPort=3306
mysqlUserName=lestat
mysqlPassword=lestat
mysqlDatabase=db_push_stats
mysqlTable=statresult

inserttime=$(date "+%Y-%m-%d %T")

hive -e \
"use $hiveDatabase; \
INSERT OVERWRITE Directory '$hdfsDir' select concat('$keyPrefix', '.', feedbackId, '.', eventName) as thekey, thedate, count(distinct pid) as value, '$inserttime' as lmt from $hiveTable where thedate='$thedate' and sid like 'rsys%' and bizType!='fake' and success=true group by feedbackId, eventName, thedate;"

sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --update-key thekey,thedate  --update-mode allowinsert --input-fields-terminated-by '\001'
