#! /bin/bash
starttime=$(date +%s)
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Start generating active device ids for chengdu yaochen precision at $(date)"
startdate=$(date -d '30 days ago' +%Y%m%d)
echo "start date: $startdate"
enddate=$(date +%Y%m%d)
echo "end date: $enddate"

hive -e \
"use db_lestat; \
insert overwrite directory '/user/root/dump'
select distinct deviceid from device where (devicemodel like '%Lenovo%' or devicemodel like '%IdeaTab%') and thedate >= '$startdate' and thedate <= '$enddate' and length(deviceid)=15;"  

rm -rf /data/ftp/yaochen/device/device.$enddate
hadoop fs -getmerge /user/root/dump /data/ftp/yaochen/device/push-device.$enddate

echo "End generating active device ids for chengdu yaochen precision at $(date)"

endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
