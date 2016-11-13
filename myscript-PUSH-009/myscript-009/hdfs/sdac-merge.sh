#! /bin/bash
sd=$1
ed=$2
basePath="/flume/sdac/sdac"
for themonth in `./monthloop.sh $sd $ed`
do
    monthdir="$basePath/$themonth"
    sudo -u flume hadoop fs -getmerge $monthdir /data/myscript/hdfs/sdac/$themonth 
    sudo -u flume hadoop fs -rm  -skipTrash  $monthdir/*
    sudo -u flume hadoop fs -put /data/myscript/hdfs/sdac/$themonth  $monthdir/

done
