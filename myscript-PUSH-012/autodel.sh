#! /bin/bash
echo -e "`date "+%Y-%m-%d %H:%M:%S"` start clean up \n\n"

echo 'clean /data/tmp/avatar/bak/'
find /data/tmp/avatar/bak/ -name "*.tar.gz" -type f -mtime +3
find /data/tmp/avatar/bak/ -name "*.tar.gz" -type f -mtime +3 | xargs rm -f
echo 'clean /data/logstash/logstash/data/'    
find /data/logstash/logstash/data/ -name "tfile*" -type f -mtime +3
find /data/logstash/logstash/data/ -name "tfile*" -type f -mtime +3 | xargs rm -f 
echo 'clean /data/logstash/logstash/data/'
find /data/logstash/logstash/data/ -name "afile*" -type f -mtime +3
find /data/logstash/logstash/data/ -name "afile*" -type f -mtime +3 | xargs rm -f

echo 'clean /data/logstash/logstash/data/app*'
find /data/logstash/logstash/data/ -name "app*" -type f -mtime +3
find /data/logstash/logstash/data/ -name "app*" -type f -mtime +3 | xargs rm -f
echo -e "`date "+%Y-%m-%d %H:%M:%S"` finish clean up \n\n"
