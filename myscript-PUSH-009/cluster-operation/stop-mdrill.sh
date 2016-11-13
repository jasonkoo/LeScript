#! /usr/bin/expect -f
set timeout 10
set user "root"

set i 2
set prefix "PUSH-00"
spawn ssh -t -p 22222 $user@$prefix$i
expect "*~]# "
send "jps | grep MdrillUi | awk '{printf(\"%s\\n\",\$1)}' |  xargs kill\r"
expect "*~]# "
send "logout\r"
expect "*~]# " 

set i 3
set prefix "PUSH-00"
spawn ssh -t -p 22222 $user@$prefix$i
expect "*~]# "
send "jps | grep NimbusServer | awk '{printf(\"%s\\n\",\$1)}' |  xargs kill\r"
expect "*~]# "
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
    send "jps | grep Supervisor | awk '{printf(\"%s\\n\",\$1)}' |  xargs kill\r"
    expect "*~]# "
    send "logout\r"
    expect "*~]# " 
}
