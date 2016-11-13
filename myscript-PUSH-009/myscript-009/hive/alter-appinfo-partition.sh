#! /bin/bash
sidfile=/data/myscript/hive/sids/$(date "+%Y%m%d")
# fetch sids and save in sids.xxxxxxxx
mysql -h 172.17.61.114  -ulestat -plestat --default-character-set=utf8 -s -N   -e "select distinct(sid) from pushappnotify.app_sid_info where sid IS NOT NULL order by sid;" > $sidfile
# fill sids array
declare -a sids=()
while read sid; do
  sids+=( $sid )
done < $sidfile
#len=${#sids[@]}
#for (( i=0; i<${len}; i++ ));
#do
#     echo  ${sids[$i]}
#done
#exit 0

echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
# drop appinfo table partitions 31 days ago
thedate=$(date -d "31 days ago" +"%Y%m%d")
echo "Drop appinfo table partitions for $thedate"
tail=""
len=${#sids[@]}
for (( i=0; i<${len}; i++ ));
do
        if [ $i -lt $(( len-1 )) ]; then
          tail+="PARTITION(sid = '${sids[$i]}', thedate = '$thedate'), "
        else
          tail+="PARTITION(sid = '${sids[$i]}', thedate = '$thedate')"
        fi
done
echo "To be dropped:  $tail"
echo "Start dropping appinfo table partitions thedate='$thedate' at $(date)"
#hive -e \
#"use db_aomp;\
#ALTER TABLE appinfo DROP IF EXISTS $tail;"

echo "End dropping appinfo table partition thedate='$thedate' at $(date)"

# add appinfo table partitions for yesterday 
thedate=$(date -d "1 days ago" +"%Y%m%d")
echo "Add appinfo table partitions for $thedate"
addSQLs=""
len=${#sids[@]}
for (( i=0; i<${len}; i++ ));
do
    	adddir="/lestat/db_aomp/appinfo/${sids[$i]}/$thedate"
	hadoop fs -test -e $adddir
        if [ $? -eq 0 ]; then
		addSQLs+="ALTER TABLE appinfo ADD IF NOT EXISTS  PARTITION (sid = '${sids[$i]}', thedate = '$thedate') LOCATION '$adddir';"
        else
                echo "$adddir does not exist !"
        fi
done

echo "To be added: $addSQLs"
echo "Start adding appinfo table partitions thedate='$thedate' at $(date)"

hive -e \
"use db_aomp;\
$addSQLs;"

echo "End adding appinfo table partitions thedate='$thedate' at $(date)"
