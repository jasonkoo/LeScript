#! /bin/bash
echo -e "`date "+%Y-%m-%d %H:%M:%S"` start clean up \n\n"

echo 'clean /data/ftp/ftpuser01/pt/'
find /data/ftp/ftpuser01/pt/ -name "*.gz" -type f -mtime +2
find /data/ftp/ftpuser01/pt/ -name "*.gz" -type f -mtime +2 | xargs rm -f

echo 'clean /data/ftp/yaochen/device/'
find /data/ftp/yaochen/device/ -name "push-device.*" -type f -mtime +20
find /data/ftp/yaochen/device/ -name "push-device.*" -type f -mtime +20  | xargs rm -f

echo 'clean /data/ftp/yaochen/feedback/'
find /data/ftp/yaochen/feedback/ -name "push-device.*" -type f -mtime +20
find /data/ftp/yaochen/feedback/ -name "push-device.*" -type f -mtime +20  | xargs rm -f


echo -e "`date "+%Y-%m-%d %H:%M:%S"` finish clean up \n\n"
