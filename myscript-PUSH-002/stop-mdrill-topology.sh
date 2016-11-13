#!/bin/sh
echo "`date "+%Y-%m-%d %H:%M:%S"` stop mdrill reader and table"
cd /data/alimama/adhoc-core/bin/
./bluewhale kill feedbacktopology
./bluewhale mdrill drop feedback,feedbackred,hit,hitred,error
#./bluewhale mdrill drop error,pncoerror
echo -e "`date "+%Y-%m-%d %H:%M:%S"` finish the process\n\n"

exit 0
