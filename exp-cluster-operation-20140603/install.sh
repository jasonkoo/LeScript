#! /usr/bin/expect -f
set timeout 30 
set package [lindex $argv 0]
set user "dummy"
set prefix "slave"
for {set i 1} {$i <= 10} {incr i 1} {
    spawn ssh -t $user@$prefix$i
    expect "*~\$ "
    send "sudo apt-get install $package\r"
    expect {
      "*\\\[Y/n\\\]" {
         send "Y\r"
	 set timeout -1
         expect "*~\$ "
	 send_user "\n\n$package installed successfully on $prefix$i!\n\n"
       }	
      "*~\$ " {
	 send_user "\n\n$package already installed on $prefix$i.\n\n"
      } 
    }
    send "logout\r"
    expect "*~\$ "
}
