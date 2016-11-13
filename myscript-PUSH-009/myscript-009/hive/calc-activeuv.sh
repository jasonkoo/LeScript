#! /bin/bash
starttime=$(date +%s)
thedate=$(date -d yesterday "+%Y%m%d")
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Start calculating active device uv at $(date)"
firstdayofthismonth=$(date +%Y%m01)
echo "firstdayofthismonth: $firstdayofthismonth"
#secs=$(date -d $firstdayofthismonth +%s)
inserttime=$(date "+%Y-%m-%d %T")

hive -e \
"use db_lestat; \
INSERT OVERWRITE Directory '/user/lestat/data/activeuv/thismonth/$thedate'  select 'null' as id, count(distinct deviceid) as uv, '$inserttime' as insertime, '0' as type from device where thedate >= '$firstdayofthismonth';"
sqoop-export --connect jdbc:mysql://10.0.4.111:3306/db_lestat --username lestat --password lestat --table activeuv --export-dir /user/lestat/data/activeuv/thismonth/$thedate --input-fields-terminated-by '\001'


thismonth=$(date +%m)
if [ $thismonth -le 03 ];then
firstdayoffiscalyear=$(date -d 'last year' +%Y0401)
else
firstdayoffiscalyear=$(date +%Y0401)
fi

echo "firstdayoffiscalyear: $firstdayoffiscalyear"

#secs=$(date -d $firstdayoffiscalyear +%s)
inserttime=$(date "+%Y-%m-%d %T")
hive -e \
"use db_lestat; \
INSERT OVERWRITE Directory '/user/lestat/data/activeuv/fiscalyear/$thedate'  select 'null' as id, count(distinct deviceid) as uv, '$inserttime' as insertime, '1' as type from device where thedate >= '$firstdayoffiscalyear';"
sqoop-export --connect jdbc:mysql://10.0.4.111:3306/db_lestat --username lestat --password lestat --table activeuv --export-dir /user/lestat/data/activeuv/fiscalyear/$thedate --input-fields-terminated-by '\001'

echo "End calculating active device uv at $(date)"

endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
