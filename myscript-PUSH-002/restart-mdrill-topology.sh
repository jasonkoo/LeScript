#!/bin/sh

echo "`date "+%Y-%m-%d %H:%M:%S"` stop mdrill reader and table"
cd /data/alimama/adhoc-core/bin/
./bluewhale kill feedbacktopology
./bluewhale mdrill drop feedback,feedbackred,hit,hitred,error
sleep 15
echo "`date "+%Y-%m-%d %H:%M:%S"` start mdrill reader and table"
./bluewhale mdrill table feedback,feedbackred,hit,hitred,error
sleep 15
./bluewhale jar ./mdrill.jar com.alimama.mdrillImport.Topology feedbacktopology  feedback,feedbackred,hit,hitred,error 24 512 1000 2014030520050
echo -e "`date "+%Y-%m-%d %H:%M:%S"` finish the process\n\n"

exit 0
