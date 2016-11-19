#! /usr/bin/expect -f
set timeout 20

spawn ssh -t cma03
expect "*~]# "
send "cd /root/alimama/adhoc-core/bin\r"
expect "*bin]# "
#send "./bluewhale kill product_salestopology\r"
#send "./bluewhale kill feedbacktopology\r"
#send "./bluewhale kill feedbackredtopology\r"
#send "./bluewhale kill hittopology\r"
#send "./bluewhale kill hitredtopology\r"
send "./bluewhale kill feedbacktopology\r"
expect "*bin]# "
send "logout\r"
expect "*~]# "
