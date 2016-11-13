#! /bin/bash
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
# drop pt table partition 61 days ago
thedate=$(date -d "61 days ago" +"%Y%m%d")
echo "Start dropping pt table partition thedate='$thedate' at $(date)"

hive -e \
"use db_lestat;\
ALTER TABLE pt DROP IF EXISTS PARTITION(thedate = '$thedate');"

echo "End dropping pt table partition thedate='$thedate' at $(date)"

# add pt table partition for yesterday 
thedate=$(date -d "2 days ago" +"%Y%m%d")
echo "Start adding pt table partition thedate='$thedate' at $(date)"

hive -e \
"use db_lestat;\
ALTER TABLE pt ADD IF NOT EXISTS PARTITION (thedate = '$thedate') LOCATION '/lestat/db_lestat/pt/$thedate';"

echo "End adding pt table partition thedate='$thedate' at $(date)"
