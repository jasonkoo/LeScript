#!/bin/sh
#LOCAL_DIR=/data/nginx_logreduce/avatar_log
LOCAL_DIR=/data/ftp/ftpuser01/pt
HDFS_DIR=/lestat/pt
TMP_DIR=/data/tmp/pt/tmp
FB_CHECK=$TMP_DIR/pt.check
FILE_LOCK=$TMP_DIR/hdfs_pt.lock


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
#x=$1
x=${1##*.}
y=(${x//-/ })
length=${#y[@]}
#echo $length
yyyy=$length-3
mm=$length-2
dd=$length-1
#echo ${y[$yyyy]}
#echo ${y[$mm]}
#echo ${y[$dd]}
echo "${y[$yyyy]}${y[$mm]}${y[$dd]}"
}

function uploadFb(){
fileName=$1
echo "uploading: "$fileName
#lzop -U -9 $fileName
gzip -9 $fileName
lzoFileName=$fileName.gz
timeStr=`date +%s`
newFileName=$fileName.$timeStr.gz
mv $lzoFileName $newFileName
dateStr=$(getDate $fileName)
HDFS_DATE_DIR=$HDFS_DIR/$dateStr
if hadoop fs -test -d $HDFS_DATE_DIR ;then
  echo 'hdfs dir existed: '$HDFS_DATE_DIR
else
  echo 'create hdfs dir: '$HDFS_DATE_DIR
  hadoop fs -mkdir $HDFS_DATE_DIR
fi
if hadoop fs -put $newFileName $HDFS_DATE_DIR ;then
  echo 'upload succeeded'
else
  echo 'upload failed'
  mv $newFileName $lzoFileName
  gzip -d $lzoFileName
  rm -f $lzoFileName
fi
}

echo "`date "+%Y-%m-%d %H:%M:%S"` start upload"

#RPS_LOGS=`find $LOCAL_DIR -name "fbfile*" ! -wholename "*.lzo" -type f -mmin +10`
RPS_LOGS=`find $LOCAL_DIR -name "*getpt.log*" ! -wholename "*.gz" ! -wholename "*.tmp" -type f -mmin +1`
#RPS_LOGS=`find $LOCAL_DIR -name "fbfile*" ! -wholename "*.lzo" -type f -mmin +1`
for log in $RPS_LOGS ; do
	uploadFb $log
done

echo -e "`date "+%Y-%m-%d %H:%M:%S"` finish upload\n\n"

exit 0


