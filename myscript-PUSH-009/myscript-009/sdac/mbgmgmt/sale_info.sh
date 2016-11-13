#! /bin/bash
themonth=$(date -d '1 days ago' +%Y%m)
thedate=$(date -d '1 days ago' +%Y%m%d)
hdfsDir=/user/lestat/stats/sdac/sale_info

hive -e \
"use sdac; \
insert overwrite directory '$hdfsDir'
select l.thedate, l.imei, l.imei2, l.p, r.model, l.countrycode, l.province, l.city, l.district, l.f, r.zimei1, r.zimei2, r.zsrlnr, r.cust_no, r.cust_name, r.so_no, r.pgi_date, r.goodsid, r.goodsname, r.sal_office, r.sal_office_t, r.country1 from (select * from sdac where themonth='$themonth' and thedate='$thedate' and isfirsttime=true and length(imei) > 4 and length(district) <= 64) l inner join sellin r on l.imei=r.zimei1"

mysqlIP=10.0.5.11
mysqlPort=3306
mysqlUserName=sales
mysqlPassword=sales@***123
mysqlDatabase=sales
mysqlTable=sale_info

sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --update-key thedate,imei  --update-mode allowinsert  --input-fields-terminated-by '\001'  --input-lines-terminated-by '\n' --input-optionally-enclosed-by '\"' --input-escaped-by '\\' --input-null-string '\0' --input-null-non-string '\0' 

#sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --update-key thedate,imei  --update-mode allowinsert --lines-terminated-by '\n' --input-fields-terminated-by '\0001' --input-optionally-enclosed-by '\"' --input-escaped-by '\"' --input-null-string '\0' --input-null-non-string '\0'
