#! /usr/bin/expect -f
set timeout 10
set dir [lindex $argv 0]
puts $dir
set user "root"
for {set i 1} {$i <= 20} {incr i 1} {
    if { $i == 9 } continue
    if { $i < 10 } {
        set prefix "PUSH-00"
    } else {
    	set prefix "PUSH-0"
    }
    spawn ssh -t -p 22222 $user@$prefix$i
    expect "*~]# "
    send "mv /etc/yum.repos.d/cobbler-config.repo /etc/yum.repos.d/cobbler-config.repo.bk\r"
    expect "*~]# "
    send "logout\r"
    expect "*~]# "
}
