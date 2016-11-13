#! /usr/bin/expect -f
set timeout 20

set user "dummy"
set prefix "slave"
set password "breakaleg"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~\$ "
    send "cd conf\r"
    expect "*~\$ "
    send "sudo su\r"
    expect "*password*"
    send "$password\r"
    expect "*#"
    send "cat limits.conf >> /etc/security/limits.conf\r"
    expect "*#"
    send "cat common-session >> /etc/pam.d/common-session\r"
    expect "*#"
    send "exit\r"    
    expect "*~\$ "
    send "logout\r"
    expect "*~\$ "
}
