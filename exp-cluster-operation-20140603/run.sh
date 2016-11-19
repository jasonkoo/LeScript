#! /bin/bash

#echo
#echo "Stop Hadoop..."
#cd /home/dummy/.script/hadoop-spark-control
#./stop-hadoop.sh


for (( i=10; i>=1; i-- ))
do
	cd /home/dummy/.script/cluster-operation
	./scala-setting.sh $i 
done

echo "Successfully Finished at $(date)"
date >> time.log

./shutdown-cluster.sh
