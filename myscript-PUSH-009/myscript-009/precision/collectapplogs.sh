#!/usr/bin/expect

set YOURDATE [exec date -d "1 days ago" -I ]
set MYDATE [exec date -d "1 days ago" +%Y%m%d ]
set timeout 3600
set username logcoper
set password copelog
set port 22222

exec mkdir -p /data/applogs/$MYDATE

set host 10.0.2.48 
set src_file /data/logs/avatarlog/$YOURDATE.*.log
set dest_file /data/applogs/$MYDATE/

spawn scp -P $port $username@$host:$src_file $dest_file 
	expect {
		"(yes/no)?"
			{
				send "yes\n"
				expect "*assword:" { send "$password\n"}
			}
		"*assword:"
			{
				send "$password\n"
			}
		}
expect {
        "100%"
                {
                        expect eof
                }
        "*No such file or directory"
                {
                        expect eof
                }
        }
