#! /bin/bash
echo "-----------------------------------------------"
starttime=$(date +%s)
echo "Start backup device table at $(date)"
thedate=$(date -d yesterday "+%Y%m%d")
echo "Copying /user/lestat/data/device to /user/lestat/data/backup/device/$thedate"
hadoop fs -cp /user/lestat/data/device /user/lestat/data/backup/device/$thedate
echo "End backup device table at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
