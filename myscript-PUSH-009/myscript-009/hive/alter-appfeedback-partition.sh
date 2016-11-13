#! /bin/bash
sidfile=/data/myscript/hive/sids/$(date "+%Y%m%d")
declare -a sids=()
# fill sids array
declare -a sids=()
while read sid; do
  sids+=( $sid )
done < $sidfile

echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
# drop appfeedback table partitions 31 days ago
thedate=$(date -d "31 days ago" +"%Y%m%d")
echo "Drop appfeedback table partitions for $thedate"
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
echo "Start dropping appfeedback table partitions thedate='$thedate' at $(date)"
#hive -e \
#"use db_aomp;\
#ALTER TABLE appfeedback DROP IF EXISTS $tail;"

echo "End dropping appfeedback table partition thedate='$thedate' at $(date)"

# add appfeedback table partitions for yesterday 
thedate=$(date -d "1 days ago" +"%Y%m%d")
echo "Add appfeedback table partitions for $thedate"
addSQLs=""
len=${#sids[@]}
for (( i=0; i<${len}; i++ ));
do
    	adddir="/lestat/db_aomp/appfeedback/${sids[$i]}/$thedate"
	hadoop fs -test -e $adddir
        if [ $? -eq 0 ]; then
		addSQLs+="ALTER TABLE appfeedback ADD IF NOT EXISTS PARTITION(sid = '${sids[$i]}', thedate = '$thedate') LOCATION '$adddir';"
        else
                echo "$adddir does not exist !"
        fi
done

echo "To be added: $addSQLs"
echo "Start adding appfeedback table partitions thedate='$thedate' at $(date)"

hive -e \
"use db_aomp;\
$addSQLs"

echo "End adding appfeedback table partitions thedate='$thedate' at $(date)"
