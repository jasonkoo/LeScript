#! /usr/bin/expect -f
set timeout 10

set user "dummy"
set prefix "slave"
set password "breakaleg"

# initial state: master to master manually
# master to slaves
spawn ssh -t $user@master
expect "*~\$ "
for {set k 1} {$k <= 10} {incr k 1} {
     send "ssh-copy-id $prefix$k\r"
     expect "*(yes/no)?"
     send "yes\r"
     expect "*password*"
     send "$password\r"
     expect "*~\$ "
}
send "logout\r"
expect "*~\$ "


for {set i 1} {$i <= 10} {incr i 1} {
    # slavei to master
    spawn ssh -t $user@$prefix$i
    expect "*~\$ "
    send "ssh-copy-id master\r"
    expect "*(yes/no)?"
    send "yes\r"
    expect "*password*"
    send "$password\r"
    expect "*~\$ "
    # slavei to slaves
    for {set j 1} {$j <= 10} {incr j 1} {
    	send "ssh-copy-id $prefix$j\r"
        expect "*(yes/no)?"
        send "yes\r"
        expect "*password*"
    	send "$password\r"
	expect "*~\$ "
    }
    send "logout\r"
    expect "*~\$ "
}
