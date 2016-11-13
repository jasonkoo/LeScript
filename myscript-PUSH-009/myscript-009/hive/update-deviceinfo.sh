#! /bin/bash

starttime=$(date +%s)
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Start updating device info at $(date)"
# Get date of yesterday
thedate=$(date -d yesterday "+%Y%m%d")

# Union with device table
hive -e \
"use db_lestat; \
INSERT OVERWRITE TABLE t2 \
select * from \
(select * from t0 where deviceid is not null and deviceid != '' UNION ALL select * from device ) unionResult"

# For each pid, retain the record with max hittime
hive -e \
"use db_lestat; \
INSERT OVERWRITE TABLE device \
select l.* from t2 l inner join (select deviceid, max(hittime) as maxht from t2 group by deviceid) r on l.deviceid = r.deviceid and l.hittime = r.maxht"
echo "End updating device info at $(date)"

endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
