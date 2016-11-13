#! /bin/bash

if [ -z "$1" ]; then
    echo "Usage: ./scala-setting.sh numSlaves"
    exit 1
fi

numSlaves=$1

echo "Number of slaves: $numSlaves"


echo
echo "remove hdfs on master..."
rm -rf /hadoop/hadoop-1/hadoop-1.2.1/dfs
rm -rf /hadoop/hadoop-1/hadoop-1.2.1/mapred

echo
echo "remove hdfs on slaves..."
./del.sh /hadoop/hadoop-1/hadoop-1.2.1/dfs
./del.sh /hadoop/hadoop-1/hadoop-1.2.1/mapred

echo
echo "Modify slaves file for Hadoop..."
rm /home/dummy/hadoop/hadoop-1/hadoop-1.2.1/conf/slaves
for (( i=1; i<=$numSlaves; i++ ))
do
        echo slave$i >> /home/dummy/hadoop/hadoop-1/hadoop-1.2.1/conf/slaves
done

echo "After modify slaves file for Hadoop, the contents in it are:"
cat /home/dummy/hadoop/hadoop-1/hadoop-1.2.1/conf/slaves

echo
echo "Copy slaves file for Hadoop to all slaves..."
./copy-to-slaves.sh /home/dummy/hadoop/hadoop-1/hadoop-1.2.1/conf/slaves hadoop/hadoop-1/hadoop-1.2.1/conf/

echo
echo "Modify slaves file for Spark..."
rm /home/dummy/spark/conf/slaves
for (( i=1; i<=$numSlaves; i++ ))
do
        echo slave$i >> /home/dummy/spark/conf/slaves
done

echo "After modify slaves file for Spark, the contents in it are:"
cat /home/dummy/spark/conf/slaves

echo
echo "Copy slaves file for Spark to all slaves..."
./copy-to-slaves.sh /home/dummy/spark/conf/slaves spark/conf/

echo
echo "Format HDFS..."
cd /home/dummy/hadoop/hadoop-1/hadoop-1.2.1
bin/hadoop namenode -format

sleep 10

echo
echo "Start Hadoop..."
cd /home/dummy/.script/hadoop-spark-control
./start-hadoop.sh

sleep 30

#echo
#echo "Loading real datasets into HDFS..."
#cd /home/dummy/dataset/real
#./load-dataset.sh

#echo
#echo "Loading synthetic datasets into HDFS..."
#cd /home/dummy/dataset/synthetic/same-seed
#./load-dataset.sh

#echo 
#echo "Loading verification datasets into HDFS..."
#cd /home/dummy/dataset/verification
#./load-dataset.sh

#sleep 10

#echo
#echo "Generate PageRank input for Hadoop and Spark..."
#cd /home/dummy/.script/job-running/pagerank
#./gen-prinput-real.sh $numSlaves
#./gen-prinput-synthetic.sh $numSlaves

#sleep 10

#echo
#echo "Stop Hadoop..."
#cd /home/dummy/.script/hadoop-spark-control
#./stop-hadoop.sh

#sleep 10

#echo
#echo "Run Hadoop PageRank Iteration..."
#cd /home/dummy/.script/job-running/pagerank
#./hadoop-priteration-real.sh $numSlaves

#sleep 10

#echo
#echo "Run Spark PageRank Iteration..."
#cd /home/dummy/.script/job-running/pagerank
#./spark-priteration-real.sh $numSlaves
