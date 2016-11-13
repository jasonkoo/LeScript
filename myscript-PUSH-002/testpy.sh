#!/bin/sh

echo "`date "+%Y-%m-%d %H:%M:%S"` stop mdrill reader and table"
cd /data/myscript/
./bw
echo -e "`date "+%Y-%m-%d %H:%M:%S"` finish the process\n\n"

exit 0
