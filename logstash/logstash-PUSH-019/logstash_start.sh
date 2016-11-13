 nohup bin/logstash agent -w 10 -f logstash_filefb.conf > lsfb.out &
nohup bin/logstash agent -w 30 -f logstash_file.conf > ls.out & 

