#! /usr/bin/expect -f
set timeout 20 

set user "dummy"
set prefix "slave"
set password "breakaleg"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~\$ "
    send "sudo sync && sudo echo 3 | sudo tee /proc/sys/vm/drop_caches\r"
    #expect "*password*"
    #send "$password\r"
    expect "*~\$ "
    send "logout\r"
    expect "*~\$ "
}
