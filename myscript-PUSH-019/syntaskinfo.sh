#! /bin/bash
thedate=$(date +%Y%m%d)
echo $thedate
filename=push_task_history.$thedate
mysql -h172.17.75.100 -upsbpmt -pqfE##gkNY_EhfHTAmg8m --default-character-set=utf8 -s -N -e "select CONCAT(task_source_sid, '_', id) as adid, task_pushtitle, task_pushcontent, task_app_pgkname, task_app_vercode, task_startdate, ExtractValue(sysmessagebody, 'SysMessage/Show/Conditions/TimeRange/RangeEnd') as task_enddate, task_adbiz_type from pushmarketing.push_task_info where task_pushtitle != '无' and task_pushcontent != '无' and task_app_pgkname is not NULL and task_app_vercode is not NULL and task_startdate >= '2014-08-01 00:00:00' and LOWER(ExtractValue(sysmessagebody, 'SysMessage/NotifVisib'))='true' order by task_startdate;" > /tmp/$filename
su - flume -c "hadoop fs -rm -r -f -skipTrash /flume/precision/taskinfo/*"
su - flume -c "hadoop fs -put /tmp/$filename /flume/precision/taskinfo"
wc -l /tmp/$filename
rm -rf /tmp/$filename
