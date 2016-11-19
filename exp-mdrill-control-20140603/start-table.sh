#! /usr/bin/expect -f
set timeout 20

spawn ssh -t cma03
expect "*~]# "
send "cd /root/alimama/adhoc-core/bin\r"
expect "*bin]# "
#send "./bluewhale mdrill table product_sales\r"
#send "./bluewhale mdrill table feedback\r"
#send "./bluewhale mdrill table feedbackred\r"
#send "./bluewhale mdrill table hit\r"
#send "./bluewhale mdrill table hitred\r"
send "./bluewhale mdrill table feedback,feedbackred,hit,hitred\r"
expect "*bin]# "
send "logout\r"
expect "*~]# "
