#! /bin/bash
hiveDatabase=sdac
hiveTable=sdac_new

mysqlIP=PUSH-011
mysqlPort=3306
mysqlUserName=lestat
mysqlPassword=lestat
mysqlDatabase=db_push_stats
mysqlTable=statresult

for i in {1..7}
do
# daily stat
themonth=$(date -d  "$i days ago" "+%Y%m")
startTime=$(date -d  "$i days ago" +"%Y%m%d 00:00:00")
endTime=$(date -d  "$i days ago" +"%Y%m%d 24:00:00")


inserttime=$(date "+%Y-%m-%d %T")

hdfsDir=/user/lestat/stats/$hiveDatabase/$hiveTable/ctr/
keyPrefix='mbgmgmt.sdac'

hive -e \
"use $hiveDatabase; \
INSERT OVERWRITE Directory '$hdfsDir' select concat('$keyPrefix', '.', countrycode) as thekey, substring(logtime, 1, 8) as thedate, count(1) as value, '$inserttime' as lmt from $hiveTable where themonth='$themonth' and logtime>='$startTime' and logtime<='$endTime' and isfirsttime=true and (p like 'Lenovo %' or p like 'Lenovo_%') and countrycode!='null' group by countrycode, substring(logtime, 1, 8);"

sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --update-key thekey,thedate  --update-mode allowinsert --input-fields-terminated-by '\001'
done
