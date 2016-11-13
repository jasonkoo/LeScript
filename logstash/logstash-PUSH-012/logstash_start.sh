nohup bin/logstash agent -w 10 -f logstash_fileapp.conf > lsapp.out &
nohup bin/logstash agent -w 30 -f logstash_file.conf > logstash_null.out &