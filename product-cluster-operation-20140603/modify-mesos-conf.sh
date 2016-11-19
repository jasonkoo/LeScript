#! /usr/bin/expect -f
set timeout 10

set user "dummy"
set prefix "slave"
set password "breakaleg"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*$"
    send "cd mesos/var/mesos/conf\r"
    expect "*$"
    send "head -n -1 foo.txt > tmp.txt\r"
    expect "*$"
    send "mv tmp.txt foo.txt\r"
    expect "*$"
    send "logout\r"
    expect "*$"
}
