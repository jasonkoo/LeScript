#! /usr/bin/expect -f
set secs [clock scan "30 days ago"]
set thedate [clock format $secs -format {%y-%m-%d}]
#set thedate "14-06-2*"
puts "log files suffix: $thedate"

set now [clock seconds]
set starttime [clock format $now -format {%Y-%m-%d %H:%M:%S}]
puts "deleting mdrill logs for $thedate at $starttime"


set timeout 10
set user "root"
for {set i 1} {$i <= 17} {incr i 1} {
    if { $i >= 9 && $i <= 13 } continue
    if { $i < 10 } {
        set prefix "PUSH-00"
    } else {
        set prefix "PUSH-0"
    }
    spawn ssh -t -p 22222 $user@$prefix$i
    expect "*~]# "
    send "cd /data/alimama/adhoc-core/logs/\r"
    expect "*]# "
    send "rm -rf *.log.$thedate\r"
    expect "*]# "
    send "logout\r"
    expect "*~]# " 
}


set now [clock seconds]
set endtime [clock format $now -format {%Y-%m-%d %H:%M:%S}]
puts "deleted mdrill logs for $thedate at $endtime"

