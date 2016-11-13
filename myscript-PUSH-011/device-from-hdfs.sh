#! /bin/bash
starttime=$(date +%s)
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Start getmerging device at $(date)"
# Get date of yesterday
thedate=$(date -d yesterday "+%Y%m%d")
echo "$thedate"
# Get merge device from HDFS to local for ftpuser02
hadoop fs -getmerge /user/lestat/data/backup/device/$thedate /data/ftp/ftpuser02/device-backup/device-$thedate.tmp
mv /data/ftp/ftpuser02/device-backup/device-$thedate.tmp /data/ftp/ftpuser02/device-backup/device-$thedate

# Delete crc file
#  The CRC is a common technique for detecting data transmission errors. CRC checksum files have the .crc extension and are used to verify the data integrity of another file. 
rm -rf  /data/ftp/ftpuser02/device-backup/.device-$thedate.tmp.crc

# Change owner
#chown -R ftpuser02:ftp /data/ftp/ftpuser02/device-backup
echo "End getmerging device at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
