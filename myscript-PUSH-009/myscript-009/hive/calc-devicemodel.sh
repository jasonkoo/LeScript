#! /bin/bash
starttime=$(date +%s)
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Start calculating device model at $(date)"
startdate=$(date -d '15 days ago' +%Y%m%d)
echo "start date: $startdate"
#startsecs=$(date -d $thedate +%s)
enddate=$(date -d yesterday +%Y%m%d)
echo "end date: $enddate"
#endsecs=$(date -d $thedate +%s)
inserttime=$(date "+%Y-%m-%d %T")

hive -e \
"ADD JAR /home/lestat/jar/lestat-hive-0.0.1-SNAPSHOT.jar; \
CREATE TEMPORARY FUNCTION sha1 as 'com.lenovo.push.marketing.hive.udf.Sha1'; \
use db_lestat; \
INSERT OVERWRITE Directory '/user/lestat/data/devicemodel/$enddate' select sha1(devicemodel) as sha1, devicemodel as device_model, count(distinct deviceid) as act_devicenum, '$inserttime' as insertime from device where (devicemodel like '%Lenovo%'  or devicemodel like '%IdeaTab%') and thedate >= '$startdate' and thedate<= '$enddate' group by devicemodel limit 10000;"

sqoop-export --connect jdbc:mysql://10.0.4.111:3306/db_lestat --username lestat --password lestat --table devicemodel --export-dir /user/lestat/data/devicemodel/$enddate --update-key sha1  --update-mode allowinsert --input-fields-terminated-by '\001'

echo "End calculating device model at $(date)"

endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
