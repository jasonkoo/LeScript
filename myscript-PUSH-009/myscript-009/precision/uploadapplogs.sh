#! /bin/bash
thedate=$(date -d "1 days ago" +%Y%m%d)
localdir=/data/applogs/$thedate
hdfsdir=/flume/precision/applogs_orig
su - flume -c "hadoop fs -put $localdir $hdfsdir"
# sudo not working, require tty
#sudo -u flume hadoop fs -put $localdir $hdfsdir

