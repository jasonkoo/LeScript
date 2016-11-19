#! /usr/bin/expect -f
set timeout 20

set user "root"
set prefix "cma0"
for {set i 1} {$i <= 3} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~]# "
    send "supervisorctl stop all\r"
    expect "*~]# "
    send "logout\r"
    expect "*~]# "
}
