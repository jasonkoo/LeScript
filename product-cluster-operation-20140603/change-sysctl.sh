#! /usr/bin/expect -f
set timeout 10
set dir [lindex $argv 0]
puts $dir
set user "root"
for {set i 14} {$i <= 17} {incr i 1} {
    if { $i < 10 } {
        set prefix "PUSH-00"
    } else {
    	set prefix "PUSH-0"
    }
    spawn ssh -t -p 22222 $user@$prefix$i
    expect "*~]# "
    send "echo '# mdrill' >> /etc/sysctl.conf\r"
    expect "*~]# "
    send "echo 'net.ipv4.ip_local_port_range = 10000 65535' >> /etc/sysctl.conf\r"
    expect "*~]# "
    send "echo 'net.core.somaxconn = 4096' >> /etc/sysctl.conf\r"
    expect "*~]# "
    send "echo 'net.core.netdev_max_backlog=16384' >> /etc/sysctl.conf\r"
    expect "*~]# "
    send "echo 'net.ipv4.tcp_max_syn_backlog=8192' >> /etc/sysctl.conf\r"
    expect "*~]# "
    send "echo 'net.ipv4.tcp_syncookies=1' >> /etc/sysctl.conf\r"
    expect "*~]# "
    send "echo 'fs.file-max = 100000' >> /etc/sysctl.conf\r"
    expect "*~]# "
    send "sysctl -p /etc/sysctl.conf\r"
    expect "*~]# "
    send "logout\r"
    expect "*~]# "
}
