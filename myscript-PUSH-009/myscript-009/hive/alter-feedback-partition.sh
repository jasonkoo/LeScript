#! /bin/bash
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
# drop feedback table partition 60 days ago
#thedate=$(date -d "60 days ago" +"%Y%m%d")
#echo "Start dropping feedback table partition thedate='$thedate' at $(date)"

#hive -e \
#"ADD JAR /home/lestat/jar/lestat-hive-0.0.1-SNAPSHOT.jar;\
#use db_lestat;\
#ALTER TABLE feedback DROP IF EXISTS PARTITION(thedate = '$thedate');"

#echo "End dropping feedback table partition thedate='$thedate' at $(date)"

# add feedback table partition for yesterday
thedate=$(date -d "1 days ago" +"%Y%m%d")
echo "Start adding feedback table partition thedate='$thedate' at $(date)"

hive -e \
"ADD JAR /home/lestat/jar/lestat-hive-0.0.1-SNAPSHOT.jar;\
use db_lestat;\
ALTER TABLE feedback ADD IF NOT EXISTS PARTITION (thedate = '$thedate') LOCATION '/lestat/db_lestat/feedback/$thedate';"

echo "End adding feedback table partition thedate='$thedate' at $(date)"
