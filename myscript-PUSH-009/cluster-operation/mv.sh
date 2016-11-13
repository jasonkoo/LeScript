#! /usr/bin/expect -f
set timeout 10
set dir [lindex $argv 0]
puts $dir
set user "root"
for {set i 1} {$i <= 17} {incr i 1} {
    if { $i >= 9 && $i <= 13 }  continue
    if { $i < 10 } {
        set prefix "PUSH-00"
    } else {
    	set prefix "PUSH-0"
    }
    spawn ssh -t -p 22222 $user@$prefix$i
    expect "*~]# "
    send "mv /root/package/mysql-connector-java-5.1.31-bin.jar /home/lestat/jar/\r"
    expect "*~]# "
    send "chown lestat:lestat /home/lestat/jar/*\r"
    expect "*~]# "
    send "logout\r"
    expect "*~]# "
}
