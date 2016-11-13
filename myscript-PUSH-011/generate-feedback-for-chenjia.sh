#! /bin/bash
starttime=$(date +%s)
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Start generating feedback for Hongkong chenjia precision at $(date)"
startdate=$(date -d '7 days ago' +%Y%m%d)
echo "start date: $startdate"
enddate=$(date  -d '1 days ago' +%Y%m%d)
echo "end date: $enddate"

#sudo -u lestat hive -S -e \
hive -e \
"ADD JAR /home/lestat/jar/lestat-hive-0.0.1-SNAPSHOT.jar; \
insert overwrite directory '/user/root/dump'
select tbl2.adid,tbl2.deviceid,tbl2.channelname,tbl2.eventtype,tbl2.accessnum,tbl2.apn,tbl2.cellid,tbl2.chargestatus,tbl2.cityname,tbl2.countrycode,tbl2.custversion,tbl2.deviceimsi,tbl2.devicemodel,tbl2.ip,tbl2.locid,tbl2.netaccesstype,tbl2.operatorcode,tbl2.osversion,tbl2.pevercode,tbl2.peversion,tbl2.sysid,tbl2.logtime from precision.taskinfo tbl1 inner join (select * from db_lestat.feedback where thedate>='$startdate' and thedate<='$enddate') tbl2 on tbl1.adid=tbl2.adid;"  

hadoop fs -getmerge /user/root/dump /tmp/push_feedback.$enddate

echo "End generating feedback for Hongkong chenjia precision at $(date)"

endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"

echo "Compress feedback"
tar zcf /tmp/push_feedback.$enddate.tar.gz  -C /tmp/ push_feedback.$enddate 

echo "Copy feedback"
expect -c "
set timeout 1200; ##设置拷贝的时间，根据目录大小决定，这里是1200秒。
spawn /usr/bin/scp -P 22222 /tmp/push_feedback.$enddate.tar.gz u_cj@172.19.2.25:/data/home/u_cj/push_data/push_feedback
expect {
\"*yes/no*\" {send \"yes\r\"; exp_continue}
\"*password*\" {send \"lebigdata\r\";} 
}
expect eof;"

echo "Del feedback"
rm -rf /tmp/push_feedback.$enddate
rm -rf /tmp/push_feedback.$enddate.tar.gz
