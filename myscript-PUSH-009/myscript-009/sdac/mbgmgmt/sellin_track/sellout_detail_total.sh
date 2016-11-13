#! /bin/bash
hive -e \
"use sales_mgmt; \
drop table if exists sellout_detail_total;\
create table sellout_detail_total as \
select l.*, r.* from (select zimei1, pgi_date as sellin_date,model as sellin_model,cust_no,cust_name,IF(length(sal_office)>2,substring(sal_office,0,2),sal_office) as sellin_country,goodsid,goodsname from sdac.sellin where length(zimei1) >= 4 group by zimei1,pgi_date,model,cust_no,cust_name,sal_office,goodsid,goodsname) l inner join (select imei,thedate as sdac_date,IF(p='\0','',p) as sdac_model,CASE f WHEN 'PLUS' THEN '3' WHEN 'PRC' THEN '3' WHEN 'ROW' THEN '1' WHEN 'GEO' THEN '1' WHEN 'TGEO' THEN '2' WHEN 'PUSH' THEN '4' else '' END as sdac_type,IF(countrycode='null','',countrycode) as sdac_country from sdac.sdac where themonth>='201501' and thedate>='20150101' and thedate<='20160131' and isfirsttime=true and length(imei)>4  group by imei,thedate,p,f,countrycode) r on l.zimei1=r.imei;"

