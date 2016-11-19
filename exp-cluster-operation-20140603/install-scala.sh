#! /usr/bin/expect -f
set timeout -1 

set user "dummy"
set prefix "slave"
set password "breakaleg"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~\$ "
    send "cd .scala\r"
    expect "*~\$ "
    send "tar zxvf scala-2.9.3.tgz\r"
    expect "*~\$ "
    send "rm scala-2.9.3.tgz\r"
    expect "*~\$ "
    send "logout\r"
    expect "*~\$ "
}
