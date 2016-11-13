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

for {set i 1} {$i <= 17} {incr i 1} {
    if { $i >= 9 && $i <= 13 } continue
    if { $i < 10 } {
        set prefix "PUSH-00"
    } else {
        set prefix "PUSH-0"
    }
    spawn ssh -t -p 22222 $user@$prefix$i
    expect "*~]# "
    send "cd /data/alimama/adhoc-core/bin/\r"
    expect "*]# "
    send "nohup ./bluewhale supervisor >supervisor.log &\r"
    expect "*out"
    send "\r"
    expect "*]# "
    send "logout\r"
    expect "*~]# " 
}

set i 2
set prefix "PUSH-00"
spawn ssh -t -p 22222 $user@$prefix$i
expect "*~]# "
send "cd /data/alimama/adhoc-core/bin/\r"
expect "*]# "
send "nohup ./bluewhale mdrillui 1107 ../lib/adhoc-web-0.18-beta.jar ./ui >ui.log &\r"
expect "*out"
send "\r"
expect "*]# "
send "logout\r"
expect "*~]# " 
