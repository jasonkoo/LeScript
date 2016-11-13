#! /bin/bash
thedate=$(date -d yesterday +%Y%m%d)
hive -e \
"use db_lestat; \
INSERT OVERWRITE Directory '/mdrill/tablelist/device/dt=$thedate/' select '$thedate'as thedate, pid, hittime, channelname, cityname, countrycode, devicemodel, deviceid, deviceidtype, operationtype, osversion, pepkgname, pevercode, peversion, pepollversion from device;"

