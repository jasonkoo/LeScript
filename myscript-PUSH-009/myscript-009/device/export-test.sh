#! /bin/bash
mysqlIP=PUSH-009
mysqlPort=3306
mysqlUserName=lestat
mysqlPassword=lestat
mysqlDatabase=test
mysqlTable=device

hdfsDir=/user/root/dump

sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --columns pid,deviceid,devicemodel,countrycode,cityname,peversion,pevercode,operationtype,deviceidtype,channelname,custversion,imsi,osversion,pepkg,pollversion,updatetime  --update-mode allowinsert --input-fields-terminated-by '\001'
