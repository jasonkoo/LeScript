#! /bin/bash
hdfsDir=/user/lestat/stats/sdac/sellin_dim_summary
hive -e \
"use sdac; \
insert overwrite directory '$hdfsDir'
select pgi_date,cust_no,cust_name,model,goodsid,goodsname, if(length(sal_office) > 2, substring(sal_office, 0, 2), sal_office), count(distinct(zimei1)) as cnt from sellin where pgi_date!='' and model!='' group by   pgi_date,cust_no,cust_name,model,goodsid,goodsname,sal_office "

mysqlIP=10.0.5.11
mysqlPort=3306
mysqlUserName=sales
mysqlPassword=sales@***123
mysqlDatabase=sales
mysqlTable=sale_in_tracking

#sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --update-key pgi_date,cust_no,cust_name,model,goodsid,goodsname,sal_office  --update-mode allowinsert  --lines-terminated-by '\n' --input-fields-terminated-by '\0001' --input-optionally-enclosed-by '\"' --input-escaped-by '\"' --input-null-string '\0' --input-null-non-string '\0'  --columns  pgi_date,cust_no,cust_name,model,goodsid,goodsname,sal_office,quantity
sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --update-key pgi_date,cust_no,cust_name,model,goodsid,goodsname,sal_office  --update-mode allowinsert  --lines-terminated-by '\n' --input-fields-terminated-by '\0001'  --columns  pgi_date,cust_no,cust_name,model,goodsid,goodsname,sal_office,quantity
