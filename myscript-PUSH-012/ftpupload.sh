#!/bin/sh
#LOCAL_DIR=/data/nginx_logreduce/avatar_log
LOCAL_DIR=/data/logstash/logstash/data
#FTP_IP=114.112.169.13
FTP_IP=172.19.1.22
#FTP_IP=192.168.12.13
FTP_PORT=21
FTP_USERNAME=push
#FTP_USERNAME=test
FTP_PASSWORD=push_1555
#FTP_PASSWORD=zaq12wsx
#FTP_TARGET_DIR=/data/FSR-push
FTP_TARGET_DIR=/data1/wenyx/log
#FTP_TARGET_DIR=write
#TMP_DIR=$LOCAL_DIR/tmp
TMP_DIR=/data/tmp/avatar/tmp
FTP_CHECK=$TMP_DIR/ftp.check
FILE_LOCK=$TMP_DIR/upload_namenode.lock
BAK_DIR=/data/tmp/avatar/bak

if [ ! -d $TMP_DIR ];
then
  echo 'create '$TMP_DIR
  mkdir -p $TMP_DIR
fi

if [ ! -d $BAK_DIR ];
then
  echo 'create '$BAK_DIR
  mkdir -p $BAK_DIR
fi

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
cd $TMP_DIR

if [ -e $FILE_LOCK ] ; then                
   echo "Other instance is running!" 
   exit 0          
else
   touch $FILE_LOCK   
   chmod 600 $FILE_LOCK 
fi

trap "rm -f $FILE_LOCK; exit" 0 1 2 3 9 15

function getFileDate(){
        echo $1 | awk -F "." '{ print $3 }'
}

function getDate(){
x=$1
y=(${x//-/ })
length=${#y[@]}
#echo $length
yyyy=$length-6
mm=$length-5
dd=$length-4
#echo ${y[$yyyy]}
#echo ${y[$mm]}
#echo ${y[$dd]}
echo "${y[$yyyy]}-${y[$mm]}-${y[$dd]}"
}

function uploadLog(){
file=$1
targetFile=${file##*/}
part1=${targetFile%.*}
part1Len=${#part1}
part2='part2'
part2Len=${#part2}

newFile=''
timeStr=`date +%s`
if test $part2Len -lt 10 ; then
    #newFileDate=`date +%Y-%m-%d`
	newFileDate=$(getDate $file)
    targetFile=rps.log.$newFileDate.$part2.$part1.$timeStr.a
    newFile=rps.log.$newFileDate.$part2.$part1.$timeStr.a.tar.gz
else
    targetFile=rps.log.$part2.$part1.$timeStr
    newFile=rps.log.$part2.$part1.$timeStr.tar.gz
fi
echo newFile $newFile
echo targetFile $targetFile
mv $file $targetFile
tar -zcf $newFile $targetFile
echo open ftp : $FTP_IP $FTP_TARGET_DIR
/usr/bin/ftp -n<<END > $FTP_CHECK
open $FTP_IP $FTP_PORT 
user $FTP_USERNAME $FTP_PASSWORD  
cd $FTP_TARGET_DIR
binary  
put $newFile $newFile.tmp
rename $newFile.tmp $newFile
dir $newFile
quit
END
localFileSize=`ls -l  $newFile | awk '{print $5}'e`
remoteFileSize=`cat $FTP_CHECK | awk '{print $5}'`
checkFile=`cat $FTP_CHECK | grep $newFile`
if [[ -n "$checkFile" &&  $localFileSize = $remoteFileSize  ]]
then
	rm -f $targetFile 
	mv $newFile ../bak/$newFile
	echo $file uploaded!
else
	 mv $targetFile $file
        rm -f $newFile
        echo "upload failed:$file"
fi
}
echo "`date "+%Y-%m-%d %H:%M:%S"` start upload"

#RPS_LOGS=`ls $LOCAL_DIR/*.* | sort -t "." -k3`  
RPS_LOGS=`find $LOCAL_DIR -name "afile*" -type f -mmin +5 | sort -n -t "-" -k 7 -k 8`
for log in $RPS_LOGS ; do
#	uploadLog $log
        echo "aaa $log"
done

echo -e "`date "+%Y-%m-%d %H:%M:%S"` finish upload\n\n"

exit 0






