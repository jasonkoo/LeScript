#! /bin/bash
echo -e "`date "+%Y%m%d %H:%M:%S"` start clean up"

echo 'clean /data/applogs/'
find /data/applogs/ -name "*" -type d -mtime +3
find /data/applogs/ -name "*" -type d -mtime +3 | xargs rm -r -f

echo -e "`date "+%Y%m%d %H:%M:%S"` finish clean up \n"
