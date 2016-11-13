#! /bin/bash
echo "---------------------------------------------------------------------------------------------------------------------"
echo
echo $(date +"%Y%m%d %T")
echo
now=$(date +%s)
grep -v '^#' /data/myscript/hdfs/del-list.conf | while read basePath validity owner 
do
  echo "Start deleting directories in $basePath $validity days ago for $owner"
  hadoop fs -ls $basePath | grep '^d' | while read line; 
  do
     dirDate=$(echo $line | awk '{print $6}')
     diff=$(( ( $now - $(date -d "$dirDate" +%s) ) / (24 * 60 * 60 ) ))
     if [ $diff -gt $validity ]; then
        deldir=$(echo $line | awk '{print $8}')
        su - $owner -c "hadoop fs -rm -r -skipTrash $deldir"
     fi
  done
  echo "End deleting"
  sleep 1m
done 
echo $(date +"%Y%m%d %T")
#< /data/myscript/hdfs/del-list.conf
