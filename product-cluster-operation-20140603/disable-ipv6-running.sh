#! /usr/bin/expect -f
set timeout 10
set dir [lindex $argv 0]
puts $dir
set user "root"
for {set i 1} {$i <= 20} {incr i 1} {
    if { $i < 10 } {
        set prefix "PUSH-00"
    } else {
    	set prefix "PUSH-0"
    }
    spawn ssh -t -p 22222 $user@$prefix$i
    expect "*~]# "
    send "echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6\r"
    expect "*~]# "
    send "echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6\r"
    expect "*~]# "
    send "logout\r"
    expect "*~]# "
}
