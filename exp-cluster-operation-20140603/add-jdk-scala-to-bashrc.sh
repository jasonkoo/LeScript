#! /usr/bin/expect -f
set timeout 20

set user "dummy"
set prefix "slave"
set password "breakaleg"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~\$ "
    send "cat conf/bashrc >> .bashrc\r"
    expect "*~\$ "
    send "source .bashrc\r"
    expect "*~\$ "
    send "logout\r"
    expect "*~\$ "
}
