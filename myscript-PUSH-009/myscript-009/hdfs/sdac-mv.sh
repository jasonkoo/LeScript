#! /bin/bash
sd=$1
ed=$2
basePath="/flume/sdac/sdac"
for themonth in `./monthloop.sh $sd $ed`
do
    monthdir="$basePath/$themonth"
    sudo -u flume hadoop fs -mkdir $monthdir
    hadoop fs -ls  $monthdir* | grep '^-' |  awk '{print $8}' |  while read srcfile;
    do
        sudo -u flume hadoop fs -mv $srcfile $monthdir
    done
    sudo -u flume hadoop fs -rmdir $monthdir\?\? 

done
