#! /usr/bin/expect -f
set timeout 30

set user "dummy"
set prefix "slave"
set password "breakaleg"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~\$ "
    send "cd .java\r"
    expect "*~\$ "
    send "./jdk-6u45-linux-x64.bin\r"
    expect "*~\$ "
    send "rm jdk-6u45-linux-x64.bin\r"
    expect "*~\$ "
    send "logout\r"
    expect "*~\$ "
}
