#! /bin/bash
themonth=$(date -d  "1 days ago" "+%Y%m")
thedate=$(date -d  "1 days ago" +"%Y%m%d")
echo "themonth: $themonth"
echo "thedate: $thedate"
tblname_pre="sellout_detail_delta"
tblname_l="sdac_dim_summary_delta"
tblname_r="sellout_dim_summary_delta"

hdfsDir=/user/lestat/stats/sdac/sdac_dim_summary_delta

hive -e \
"use sales_mgmt; \
drop table if exists $tblname_l; \
create table $tblname_l as \
select sdac_date,sdac_model,sdac_type,sdac_country, count(distinct imei) as sdac_qty from (select imei,thedate as sdac_date,IF(p='\0','',p) as sdac_model, CASE f WHEN 'PLUS' THEN '3' WHEN 'PRC' THEN '3' WHEN 'ROW' THEN '1' WHEN 'GEO' THEN '1' WHEN 'TGEO' THEN '2' WHEN 'PUSH' THEN '4' else '0' END as sdac_type, IF(countrycode='null','',countrycode) as sdac_country from sdac.sdac where themonth='$themonth' and thedate='$thedate' and isfirsttime=true) tmp group by sdac_date,sdac_model,sdac_type,sdac_country; \
drop table if exists $tblname_r; \
create table $tblname_r as \
select sdac_date,sdac_model,sdac_type,sdac_country, count(distinct zimei1) as sellout_qty from $tblname_pre group by sdac_date,sdac_model,sdac_type,sdac_country; \
insert overwrite directory '$hdfsDir' \
select l.sdac_date,l.sdac_model,l.sdac_type,l.sdac_country,IF(r.sellout_qty is NULL, '', r.sellout_qty), l.sdac_qty from $tblname_l  l left outer join $tblname_r r on l.sdac_date=r.sdac_date and l.sdac_model=r.sdac_model and l.sdac_type=r.sdac_type and l.sdac_country=r.sdac_country;"


mysqlIP=10.0.5.11
mysqlPort=3306
mysqlUserName=sales
mysqlPassword=sales@***123
mysqlDatabase=sales
mysqlTable=sdac_info

sqoop-export --connect jdbc:mysql://$mysqlIP:$mysqlPort/$mysqlDatabase --username $mysqlUserName --password $mysqlPassword --table $mysqlTable --export-dir $hdfsDir --update-key thedate,model.model_type,countrycode  --update-mode allowinsert --input-fields-terminated-by '\001'  --input-lines-terminated-by '\n' 
 
