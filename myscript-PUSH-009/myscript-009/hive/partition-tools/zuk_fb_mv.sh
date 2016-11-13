#! /bin/bash
for thedate in `./dateloop 20150719 20151214`
do
  su - flume -c "hadoop fs -mv /flume/zuk/feedback/$thedate/* /flume/worldwide/feedback/$thedate/"
done
