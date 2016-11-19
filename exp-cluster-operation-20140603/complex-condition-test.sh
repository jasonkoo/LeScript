#! /usr/bin/expect -f
set timeout 20

#set arg1 [lindex $argv 0]
#set arg2 [lindex $argv 1]
#puts "$arg1,$arg2"

#set name "Jason"
#string length $name

for {set i 1} {$i <= 20} {incr i 1} {
    if {$i >= 9 && $i <= 13} continue
    if {$i >= 18} break
    if {$i < 10} {
        puts "0$i"
    } else {
        puts "$i"
    }
    
}
