#!/bin/sh
#LOCAL_DIR=/data/nginx_logreduce/avatar_log
LOCAL_DIR=/data/logstash/logstash/data
HDFS_DIR=/lestat/aomp/appinfo
TMP_DIR=/data/tmp/appinfo/tmp
APPINFO_CHECK=$TMP_DIR/appinfo.check
FILE_LOCK=$TMP_DIR/hdfs_appinfo.lock


if [ ! -d $TMP_DIR ];
then
  echo 'create '$TMP_DIR
  mkdir -p $TMP_DIR
fi

cd $TMP_DIR

if [ -e $FILE_LOCK ] ; then                
   echo "Other instance is running!" 
   exit 0          
else
   touch $FILE_LOCK   
   chmod 600 $FILE_LOCK 
fi

trap "rm -f $FILE_LOCK; exit" 0 1 2 3 9 15

function getDate(){
x=$1
y=(${x//-/ })
length=${#y[@]}
index=$length-3
echo "${y[$index]}"
#yyyy=$length-5
#mm=$length-4
#dd=$length-3
#echo ${y[$yyyy]}
#echo ${y[$mm]}
#echo ${y[$dd]}
#echo "${y[$yyyy]}${y[$mm]}${y[$dd]}"
}

function getSid(){
x=$1
y=(${x//-/ })
length=${#y[@]}
#echo $length
sid=$length-8
echo "${y[$sid]}"
}

function uploadFb(){
fileName=$1
echo "uploading: "$fileName
#lzop -U -9 $fileName
bzip2 -9 $fileName
#lzoFileName=$fileName.lzo
lzoFileName=$fileName.bz2
timeStr=`date +%s`
#newFileName=$fileName.$timeStr.lzo
newFileName=$fileName.$timeStr.bz2
mv $lzoFileName $newFileName
#dateStr=`date +%Y%m%d`
dateStr=$(getDate $fileName)
#sid=$(getSid $fileName)
HDFS_DATE_DIR=$HDFS_DIR/$dateStr
if hadoop fs -test -d $HDFS_DATE_DIR ;then
  echo 'hdfs dir existed: '$HDFS_DATE_DIR
else
  echo 'create hdfs dir: '$HDFS_DATE_DIR
  hadoop fs -mkdir -p $HDFS_DATE_DIR
fi
if hadoop fs -put $newFileName $HDFS_DATE_DIR ;then
  echo 'upload succeeded'
else
  echo 'upload failed'
  mv $newFileName $lzoFileName
# lzop -d $lzoFileName
  bzip2 -d $lzoFileName
  rm -f $lzoFileName
fi
}

echo "`date "+%Y-%m-%d %H:%M:%S"` start upload"

#RPS_LOGS=`find $LOCAL_DIR -name "fbfile*" ! -wholename "*.lzo" -type f -mmin +10`
RPS_LOGS=`find $LOCAL_DIR -name "appinfo*" ! -wholename "*.bz2" -type f -mmin +10`
#RPS_LOGS=`find $LOCAL_DIR -name "fbfile*" ! -wholename "*.lzo" -type f -mmin +1`
for log in $RPS_LOGS ; do
	uploadFb $log
done

echo -e "`date "+%Y-%m-%d %H:%M:%S"` finish upload\n\n"

exit 0

