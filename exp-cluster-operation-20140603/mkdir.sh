#! /usr/bin/expect -f
set timeout 10
set dir [lindex $argv 0]
#puts $dir
set user "dummy"
set prefix "slave"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~\$ "
    send "mkdir -p $dir\r"
    expect "*~\$ "
    send "logout\r"
    expect "*~\$ "
}
