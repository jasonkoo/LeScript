#! /usr/bin/expect -f
set timeout 10
#puts $dir
set user "dummy"
set prefix "slave"
set password "breakaleg"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*$"
    send "sudo apt-get install libcppunit-dev libcppunit-doc\r"
    expect "*password*"
    send "$password\r"
    expect "*\\\[Y/n\\\]"
    send "Y\r"
    expect "*$" 
    send "logout\r"
    expect "*$"
}
