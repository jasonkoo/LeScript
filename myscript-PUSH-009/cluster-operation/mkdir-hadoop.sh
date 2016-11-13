#! /usr/bin/expect -f
set timeout 20
#puts $dir
set user "dummy"
set prefix "slave"
set password "breakaleg"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~\$ "
    send "sudo su\r"
    #expect "*password*"
    #send "$password\r"
    expect "*#"
    send "mkdir -p /hadoop/hadoop-1/hadoop-1.2.1\r"
    expect "*#"
    send "chown -R dummy:dummy /hadoop\r"
    expect "*#"
    send "exit\r"
    expect "*~\$ "
    send "logout\r"
    expect "*~\$ "
}
