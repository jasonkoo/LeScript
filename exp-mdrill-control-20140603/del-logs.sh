#! /usr/bin/expect -f
set timeout 20

set user "root"
set prefix "cma0"
for {set i 1} {$i <= 3} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~]# "
    send "rm -rf /root/alimama/adhoc-core/logs/*\r"
    expect "*~]# "
    send "rm -rf /root/alimama/adhoc-core/bin/*.log\r"
    expect "*~]# "
    send "logout\r"
    expect "*~]# "
}
