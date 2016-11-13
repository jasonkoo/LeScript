#! /bin/bash
echo "---------------------------------------------"
thedate=$(date -d "60 days ago" +"%Y%m%d")
deldir=/lestat/feedback/$thedate
hadoop fs -test -e $deldir
if [ $? -eq 0 ]; then
   echo "deleting $deldir at $(date)"
   hadoop fs -rm -r -skipTrash $deldir
   echo "$deldir deleted at $(date)"
else
   echo "$deldir does not exist!"
fi