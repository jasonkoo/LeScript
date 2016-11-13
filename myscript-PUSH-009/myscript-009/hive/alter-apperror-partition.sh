#! /bin/bash
sidfile=/data/myscript/hive/sids/$(date "+%Y%m%d")
declare -a sids=()                                                                                                                                                                            
# fill sids array
declare -a sids=()
while read sid; do
  sids+=( $sid )
done < $sidfile

echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
# drop apperror table partitions 31 days ago
thedate=$(date -d "31 days ago" +"%Y%m%d")
echo "Drop apperror table partitions for $thedate"
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
echo "Start dropping apperror table partitions thedate='$thedate' at $(date)"
#hive -e \
#"use db_aomp;\
#ALTER TABLE apperror DROP IF EXISTS $tail;"

echo "End dropping apperror table partition thedate='$thedate' at $(date)"

# add apperror table partitions for yesterday
thedate=$(date -d "1 days ago" +"%Y%m%d")
echo "Add apperror table partitions for $thedate"
addSQLs=""
len=${#sids[@]}
for (( i=0; i<${len}; i++ ));
do
    	adddir="/lestat/db_aomp/apperror/${sids[$i]}/$thedate"
	hadoop fs -test -e $adddir
        if [ $? -eq 0 ]; then
		addSQLs+="ALTER TABLE apperror ADD IF NOT EXISTS PARTITION(sid = '${sids[$i]}', thedate = '$thedate') LOCATION '$adddir';"
        else
                echo "$adddir does not exist !"
        fi
done

echo "To be added: $addSQLs"
echo "Start adding apperror table partitions thedate='$thedate' at $(date)"

hive -e \
"use db_aomp;\
$addSQLs"

echo "End adding apperror table partitions thedate='$thedate' at $(date)"
