#! /bin/bash
thedate=$(date -d '30 days ago' +'%Y%m%d 00:00:00')
curl http://10.0.4.109:8983/solr/device/update?commit=true -H "Content-Type: text/xml" --data-binary '<delete><query>thedate:[* to \"$thedate\"]</query></delete>'
