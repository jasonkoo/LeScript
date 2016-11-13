#! /usr/bin/expect -f
set timeout 10
set dir [lindex $argv 0]
puts $dir
set user "root"
for {set i 2} {$i <= 20} {incr i 1} {
    if { $i < 10 } {
        set prefix "PUSH-00"
    } else {
    	set prefix "PUSH-0"
    }
    spawn ssh -t -p 22222 $user@$prefix$i
    expect "*~]# "
    send "echo '# for CDH' >> /etc/sysctl.conf\r"
    expect "*~]# "
    send "echo 'vm.swappiness = 0' >> /etc/sysctl.conf\r"
    expect "*~]# "
    send "sysctl -p /etc/sysctl.conf\r"
    expect "*~]# "
    send "hostname\r"
    expect "*~]# "
    send "cat /proc/sys/vm/swappiness\r"
    expect "*~]# "
    send "logout\r"
    expect "*~]# "
}
