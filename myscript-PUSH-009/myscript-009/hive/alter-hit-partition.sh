#! /bin/bash
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
# drop hit table partition 31 days ago
thedate=$(date -d "31 days ago" +"%Y%m%d")
echo "Start dropping hit table partition thedate='$thedate' at $(date)"

hive -e \
"ADD JAR /home/lestat/jar/lestat-hive-0.0.1-SNAPSHOT.jar;\
use db_lestat;\
ALTER TABLE hit DROP IF EXISTS PARTITION(thedate = '$thedate');"

echo "End dropping hit table partition thedate='$thedate' at $(date)"

# add hit table partition for yesterday
thedate=$(date -d "1 days ago" +"%Y%m%d")
echo "Start adding hit table partition thedate='$thedate' at $(date)"

hive -e \
"ADD JAR /home/lestat/jar/lestat-hive-0.0.1-SNAPSHOT.jar;\
use db_lestat;\
ALTER TABLE hit ADD IF NOT EXISTS PARTITION (thedate = '$thedate') LOCATION '/lestat/db_lestat/hit/$thedate';"

echo "End adding hit table partition thedate='$thedate' at $(date)"
