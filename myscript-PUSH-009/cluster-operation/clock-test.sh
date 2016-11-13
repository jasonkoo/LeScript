#! /usr/bin/expect -f
set timeout 10
set secs [clock scan "30 days ago"]
set thedate [clock format $secs -format {%y-%m-%d}]
puts $thedate
set now [clock seconds]
set starttime [clock format $now -format {%Y-%m-%d %H:%M:%S}]
puts "deleting mdrill logs for $thedate at $starttime"
