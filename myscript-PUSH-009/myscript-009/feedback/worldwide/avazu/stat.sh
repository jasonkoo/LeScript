#! /bin/bash
thedate=$(date -d '1 days ago' +%Y%m%d)

hiveDatabase=worldwide
hiveTable=feedback


mysqlIP=PUSH-011
mysqlPort=3306
mysqlUserName=lestat
mysqlPassword=lestat
mysqlDatabase=db_push_stats
mysqlTable=avazu_statresult

hdfsDir=/user/lestat/stats/$hiveDatabase/avazu/feedback/$thedate
inserttime=$(date "+%Y-%m-%d %T")

hive -e \
"use $hiveDatabase; \
INSERT OVERWRITE Directory '$hdfsDir' select concat('avazu.feedback.avazu_20110923654321_xxxxxx.', eventName) as thekey, thedate, 'NE', count(distinct pid) as value, '$inserttime' as lmt from $hiveTable where thedate='$thedate' and success=true and feedbackid like 'avazu_20110923654321_%' and length(eventName) > 1 group by eventName,thedate;"

sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --update-key thekey,thedate,errcode  --update-mode allowinsert --input-fields-terminated-by '\001'

hdfsDir=/user/lestat/stats/$hiveDatabase/avazu/error/$thedate
inserttime=$(date "+%Y-%m-%d %T")

hive -e \
"use $hiveDatabase; \
INSERT OVERWRITE Directory '$hdfsDir' select concat('avazu.error.avazu_20110923654321_xxxxxx.', eventName) as thekey, thedate, errcode, count(distinct pid) as value, '$inserttime' as lmt from $hiveTable where thedate='$thedate' and success=false and feedbackid like 'avazu_20110923654321_%' and length(eventName) > 1 group by eventName,thedate,errcode;"

sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --update-key thekey,thedate,errcode  --update-mode allowinsert --input-fields-terminated-by '\001'
