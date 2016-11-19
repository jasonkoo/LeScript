#! /bin/bash
for ((i=1; i<=3; i++))
do
	scp /root/alimama/adhoc-core/conf/storm.yaml cma0$i:/root/alimama/adhoc-core/conf
done

