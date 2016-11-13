#! /bin/bash
starttime=$(date +%s)
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Start calculating user disturbance at $(date)"
# Get the date of yesterday
thedate=$(date -d yesterday "+%Y%m%d")

inserttime=$(date "+%Y-%m-%d %T")

# Compute user disturbance and store results in HDFS
hive -e \
"ADD JAR /home/lestat/jar/lestat-hive-0.0.1-SNAPSHOT.jar; \
use db_lestat; \
INSERT OVERWRITE Directory '/user/lestat/data/disturbance/$thedate' \
select 'null' as id, '$thedate' as thedate, hit, count(*) as users, '$inserttime' as inserttime from (select pid, sum(IF(result='0', 1, 0)) as hit from db_lestat.hit where thedate='$thedate' group by pid) stage1 group by hit;"

# Export results from HDFS to MySQL
sqoop-export --connect jdbc:mysql://10.0.4.111:3306/db_stream --username lestat --password lestat --table disturbance --export-dir /user/lestat/data/disturbance/$thedate --input-fields-terminated-by '\001'

echo "End calculating user disturbance at $(date)"

endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
