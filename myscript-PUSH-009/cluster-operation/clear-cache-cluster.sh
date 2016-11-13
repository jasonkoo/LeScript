#! /usr/bin/expect -f
set timeout 200 
set user "root"
for {set i 1} {$i <= 20} {incr i 1} {
    if { $i < 10 } {
        set prefix "PUSH-00"
    } else {
        set prefix "PUSH-0"
    }
    spawn ssh -t -p 22222 $user@$prefix$i
    expect "*~]# "
    send "sudo sync && sudo echo 3 | sudo tee /proc/sys/vm/drop_caches\r"
    expect "*~]# "
    send "logout\r"
    expect "*~]# "
}
