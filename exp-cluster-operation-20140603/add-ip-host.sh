#! /usr/bin/expect -f
set timeout 10

set user "dummy"
set prefix "slave"
set password "breakaleg"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~\$ "
    send "sudo su\r"
    expect "*password*"
    send "$password\r"
    expect "*#"
    send "cat conf/ip-host >> /etc/hosts\r"
    expect "*#"
    send "exit\r"
    expect "*~\$ "
    send "logout\r"
    expect "*~\$ "
}
