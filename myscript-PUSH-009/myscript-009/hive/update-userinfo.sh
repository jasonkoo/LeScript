#! /bin/bash

starttime=$(date +%s)
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Start updating user info at $(date)"
# Get date of yesterday
thedate=$(date -d yesterday "+%Y%m%d")

# Union with user table
hive -e \
"use db_lestat; \
INSERT OVERWRITE TABLE t1 \
select * from \
(select * from t0 UNION ALL select * from user) unionResult"

# For each pid, retain the record with max hittime
hive -e \
"use db_lestat; \
INSERT OVERWRITE TABLE user \
select l.* from t1 l join (select pid, max(hittime) as maxht from t1 group by pid) r on l.pid = r.pid and l.hittime = r.maxht"
echo "End updating user info at $(date)"

endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
