#! /bin/bash
starttime=$(date +%s)
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Start transforming hit at $(date)"
# Get date of yesterday
thedate=$(date -d yesterday "+%Y%m%d")

# filter fields and transform JSON to '\001' sep
hive -e \
"ADD JAR /home/lestat/jar/lestat-hive-0.0.1-SNAPSHOT.jar; \
use db_lestat; \
INSERT OVERWRITE TABLE t0 \
select \
unix_timestamp(hitTime, 'MMM d, yyyy h:mm:ss a') as hittime, pid, accessNum, apn, cellId, channelName, chargeStatus, cityName, countryCode, createDate, custVersion, deviceIMSI, deviceModel, deviceId, deviceIdType, ip, latitude, locId, longitude, modifyDate, netaccessType, operationType, operatorCode, osVersion, pePkgName, peVerCode, peVersion, pePollVersion, sysId, thedate from hit where thedate='$thedate' and pid is not NULL and pid !='' and deviceid is not NULL and deviceid != ''"

echo "End transforming hit at $(date)"

endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
