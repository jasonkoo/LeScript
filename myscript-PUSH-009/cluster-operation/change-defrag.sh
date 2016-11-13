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
    send "echo never > /sys/kernel/mm/redhat_transparent_hugepage/defrag\r"
    expect "*~]# "
    send "echo '# Disable Transparent Huge Pages' >> /etc/rc.local\r"
    expect "*~]# "
    send "echo 'echo never > /sys/kernel/mm/redhat_transparent_hugepage/defrag' >> /etc/rc.local\r"
    expect "*~]# "
    send "hostname\r"
    expect "*~]# "
    send "cat /sys/kernel/mm/redhat_transparent_hugepage/defrag\r"
    expect "*~]# "
    send "logout\r"
    expect "*~]# "
}
