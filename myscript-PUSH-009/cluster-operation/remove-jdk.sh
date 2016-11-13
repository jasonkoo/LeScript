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
    send "rpm -e --nodeps java-1.6.0-openjdk-1.6.0.0-1.50.1.11.5.el6_3.x86_64 libvirt-java-0.4.9-1.el6.noarch tzdata-java-2012j-1.el6.noarch libguestfs-java-1.16.34-2.el6.x86_64 java-1.7.0-openjdk-1.7.0.9-2.3.4.1.el6_3.x86_64\r"
    expect "*~]# "
    send "logout\r"
    expect "*~]# "
}
