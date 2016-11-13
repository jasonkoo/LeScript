#! /bin/bash
thedate=$(date -d '1 days ago' +%Y%m%d)

hiveDatabase=zuk
hiveTable=feedback

hdfsDir=/user/lestat/stats/$hiveDatabase/fake/error/$thedate
keyPrefix='fake.error'

mysqlIP=10.0.76.200
mysqlPort=3306
mysqlUserName=lestat
mysqlPassword=lestat
mysqlDatabase=db_push_stats
mysqlTable=statresult

inserttime=$(date "+%Y-%m-%d %T")

hive -e \
"use $hiveDatabase; \
INSERT OVERWRITE Directory '$hdfsDir' select concat('$keyPrefix', '.', feedbackId, '.', value, '.', eventName) as thekey, thedate, count(distinct pid), '$inserttime' as lmt from $hiveTable where thedate='$thedate' and sid like 'rsys%' and bizType='fake' and success=false group by feedbackId, value, eventName, thedate;"

sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --update-key thekey,thedate  --update-mode allowinsert --input-fields-terminated-by '\001'
