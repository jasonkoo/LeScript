#! /bin/bash
hdfsDir=/user/lestat/stats/sdac/sellin_info
hive -e \
"use sdac; \
insert overwrite directory '$hdfsDir'
select pgi_date, model, count(distinct zimei1) from sellin where pgi_date!='' and model!='' group by pgi_date, model"
mysqlIP=10.0.5.11
mysqlPort=3306
mysqlUserName=sales
mysqlPassword=sales@***123
mysqlDatabase=sales
mysqlTable=sale_in_info

sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --update-key thedate,model  --update-mode allowinsert --lines-terminated-by '\n' --input-fields-terminated-by '\0001' --input-optionally-enclosed-by '\"' --input-escaped-by '\"'
