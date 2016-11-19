#! /usr/bin/expect -f
set timeout 20

set dir [lindex $argv 0]
#puts $dir
set user "root"
set prefix "cma0"
for {set i 1} {$i <= 3} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~]# "
    send "rm -rf $dir\r"
    expect "*~]# "
    send "logout\r"
    expect "*~]# "
}
