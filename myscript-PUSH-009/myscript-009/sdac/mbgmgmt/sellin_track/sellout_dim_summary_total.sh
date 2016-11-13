#! /bin/bash
tblname="sellout_detail_total"
hdfsDir=/user/lestat/stats/sdac/sellout_dim_summary_total

hive -e \
"use sales_mgmt; \
drop table if exists $tblname;\
create table $tblname as \
select l.*, r.* from (select zimei1, pgi_date as sellin_date,model as sellin_model,cust_no,cust_name,IF(length(sal_office)>2,substring(sal_office,0,2),sal_office) as sellin_country,goodsid,goodsname from sdac.sellin where length(zimei1) >= 4 group by zimei1,pgi_date,model,cust_no,cust_name,sal_office,goodsid,goodsname) l inner join (select imei,thedate as sdac_date,IF(p='\0','',p) as sdac_model,CASE f WHEN 'PLUS' THEN '3' WHEN 'PRC' THEN '3' WHEN 'ROW' THEN '1' WHEN 'GEO' THEN '1' WHEN 'TGEO' THEN '2' WHEN 'PUSH' THEN '4' else '0' END as sdac_type,IF(countrycode='null','',countrycode) as sdac_country from sdac.sdac where themonth>='201501' and thedate>='20150101' and thedate<='20160131' and isfirsttime=true and length(imei)>4  group by imei,thedate,p,f,countrycode) r on l.zimei1=r.imei;"

hive -e \
"use sales_mgmt; \
insert overwrite directory '$hdfsDir'
select sdac_date,sellin_date,cust_no,cust_name,sellin_model,goodsid,goodsname,sellin_country, count(distinct zimei1) from $tblname group by sdac_date,sellin_date,cust_no,cust_name,sellin_model,goodsid,goodsname,sellin_country"

mysqlIP=10.0.5.11
mysqlPort=3306
mysqlUserName=sales
mysqlPassword=sales@***123
mysqlDatabase=sales
mysqlTable=sale_in_activation_tmp

sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --update-key thedate,pgi_date,cust_no,cust_name,model,goodsid,goodsname,sal_office  --update-mode allowinsert --input-fields-terminated-by '\001'  --input-lines-terminated-by '\n' --input-optionally-enclosed-by '\"' --input-escaped-by '\\' --input-null-string '\0' --input-null-non-string '\0'
