#! /bin/bash
starttime=$(date +%s)
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Start generating push task history for Hongkong chenjia precision at $(date)"
enddate=$(date  -d '1 days ago' +%Y%m%d)

#sudo -u lestat hive -S -e \
hadoop fs -cat /flume/precision/taskinfo/*  >> /tmp/push_task_history.$enddate

echo "End generating push task history for Hongkong chenjia precision at $(date)"

endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"

echo "Copy push task history"
expect -c "
set timeout 1200; ##设置拷贝的时间，根据目录大小决定，这里是1200秒。
spawn /usr/bin/scp -P 22222 /tmp/push_task_history.$enddate u_cj@172.19.2.25:/data/home/u_cj/push_data/push_task_history
expect {
\"*yes/no*\" {send \"yes\r\"; exp_continue}
\"*password*\" {send \"lebigdata\r\";} 
}
expect eof;"

echo "Del push task history"
rm -rf /tmp/push_task_history.$enddate
