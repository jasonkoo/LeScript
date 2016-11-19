#! /usr/bin/expect -f
set timeout 20

spawn ssh -t cma03
expect "*~]# "
send "cd /root/alimama/adhoc-core/bin\r"
expect "*bin]# "
#send "./bluewhale mdrill drop product_sales\r"
#send "./bluewhale mdrill drop feedback\r"
#send "./bluewhale mdrill drop feedbackred\r"
#send "./bluewhale mdrill drop hit\r"
#send "./bluewhale mdrill drop hitred\r"
send "./bluewhale mdrill drop feedback,feedbackred,hit,hitred\r"
expect "*bin]# "
send "logout\r"
expect "*~]# "
