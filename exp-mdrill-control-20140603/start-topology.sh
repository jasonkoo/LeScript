#! /usr/bin/expect -f
set timeout 20

spawn ssh -t cma03
expect "*~]# "
send "cd /root/alimama/adhoc-core/bin\r"
expect "*bin]# "
#send "./bluewhale jar ./mdrill.jar com.alimama.mdrillImport.Topology product_salestopology product_sales 3 256 1000\r"
#send "./bluewhale jar ./mdrill.jar com.alimama.mdrillImport.Topology feedbacktopology feedback 3 256 1000\r"
#send "./bluewhale jar ./mdrill.jar com.alimama.mdrillImport.Topology feedbackredtopology feedbackred 3 256 1000\r"
#send "./bluewhale jar ./mdrill.jar com.alimama.mdrillImport.Topology hittopology hit 3 256 1000\r"
#send "./bluewhale jar ./mdrill.jar com.alimama.mdrillImport.Topology hitredtopology hitred 3 256 1000\r"
send "./bluewhale jar ./mdrill.jar com.alimama.mdrillImport.Topology feedbacktopology feedback,feedbackred,hit,hitred 3 256 1000\r"
expect "*bin]# "
send "logout\r"
expect "*~]# "
