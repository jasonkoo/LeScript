#! /usr/bin/expect -f
set timeout 10000
#puts $dir
set user "dummy"
set prefix "slave"
set password "breakaleg"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*$"
    send "sudo apt-get install gcc g++ build-essential libopenmpi-dev openmpi-bin default-jdk cmake zlib1g-dev git\r"
    expect "*password*"
    send "$password\r"
    expect "*\\\[Y/n\\\]"
    send "Y\r"
    expect "dummy@slave*$" 
    send "logout\r"
    expect "*$"
}
