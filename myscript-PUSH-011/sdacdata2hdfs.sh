#! /bin/sh
LOCAL_DIR=/data/ftp/ftpuser02/sdac
HDFS_DIR=/lestat/sdac
TMP_DIR=/data/tmp/sdac/tmp
SDAC_CHECK=$TMP_DIR/sdac.check
FILE_LOCK=$TMP_DIR/hdfs_sdac.lock

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

function upload(){
fileName=$1
newFileName=$fileName.done
echo "uploading: "$fileName
if hadoop fs -put $fileName $HDFS_DIR ;then
  echo 'upload succeeded'
  mv $fileName $newFileName
else
  echo 'upload failed'
fi
}

echo "`date "+%Y-%m-%d %H:%M:%S"` start upload"

SDAC_LOGS=`find $LOCAL_DIR -name "*hdfs.log*" ! -wholename "*.done" ! -wholename "*.tmp" -type f -mmin +1`
for log in $SDAC_LOGS ; do
	upload $log
done

echo -e "`date "+%Y-%m-%d %H:%M:%S"` finish upload\n\n"

exit 0
