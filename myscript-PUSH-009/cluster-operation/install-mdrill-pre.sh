#! /usr/bin/expect -f
set timeout 300
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
    send "cd mydownload\r"
    expect "*]# "
    send "source install-libs.sh\r"
    expect "*]# "
    send "logout\r"
    expect "*~]# "
}
