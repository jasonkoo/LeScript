#! /usr/bin/expect -f
set timeout 10

set user "dummy"
set prefix "slave"
set password "breakaleg"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~\$ "
    send "sudo shutdown -h now\r"
#   expect "*password*"
#   send "$password\r"
    send "logout\r"
    expect "*~\$ "
}
