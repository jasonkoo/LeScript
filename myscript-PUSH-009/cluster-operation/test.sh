#! /usr/bin/expect -f
set timeout 10
set user "root"

set i 3 
set prefix "PUSH-00"
spawn ssh -t -p 22222 $user@$prefix$i
expect "*~]# "
send "cd /data/alimama/adhoc-core/bin/\r"
expect "*]# "
send "nohup ./bluewhale nimbus >nimbus.log &\r"
expect "*out"
send "\r"
expect "*]# "
send "logout\r"
expect "*~]# " 
