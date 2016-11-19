#! /usr/bin/expect -f
set timeout 10

set user "dummy"
set prefix "slave"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*$"
    send "cd mesos/var/mesos/conf\r"
    expect "*$"
    send "cat ~/conf/mesos.conf.slave > mesos.conf\r"
    expect "*$"
    send "logout\r"
    expect "*$"
}
