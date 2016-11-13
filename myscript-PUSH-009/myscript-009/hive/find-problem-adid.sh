#! /bin/bash
idtype="pid"
adid="rinter2_2c91bc544739128101474724c1f6006c"
startdate=""
enddate=""
ec="0"
enc="1"
# Find pids or deviceids on which a particular adid had ec occured and enc not occured
hive -e \
"ADD JAR /home/lestat/jar/lestat-hive-0.0.1-SNAPSHOT.jar; \
use db_lestat; \
INSERT OVERWRITE Directory '/user/lestat/data/problemids/' \
select $idtype, events from \
(select $idtype, collect_set(eventtype) as events from feedback where thedate >= '$startdate' and thedate <= '$enddate' and adid='$adid' group by $idtype) t1
where array_contains(events, '$ec') and !array_contains(events, '$enc')"
