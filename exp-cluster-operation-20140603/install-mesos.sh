#! /usr/bin/expect -f
set timeout 20

set user "dummy"
set prefix "slave"
set password "breakaleg"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~\$ "
    send "cd package\r"
    expect "*~\$ "
    send "tar zxvf mesos-0.10.0-incubating.tar.gz\r"
    expect "*~\$ "
    send "cd mesos-0.10.0\r"
    expect "*~\$ " 
    send "./configure --with-java-home=/home/dummy/.java/jdk1.6.0_45 --prefix=/home/dummy/mesos\r"
    expect "*~\$ "
    send "make\r"
    expect "*~\$ "
    send "make install\r"
    expect "*~\$ "
    send "logout\r"
    expect "*~\$ "
}
