#! /usr/bin/expect -f
set timeout 20

set user "root"
set prefix "cma0"
for {set i 3} {$i >= 1} {incr i -1} {
    spawn ssh -t $user@$prefix$i
    expect "*~]# "
    send "supervisorctl start all\r"
    expect "*~]# "
    send "logout\r"
    expect "*~]# "
}
