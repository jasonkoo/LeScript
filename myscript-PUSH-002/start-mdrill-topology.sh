#!/bin/sh

#echo "`date "+%Y-%m-%d %H:%M:%S"` stop mdrill reader and table"
cd /data/alimama/adhoc-core/bin/
echo "`date "+%Y-%m-%d %H:%M:%S"` start mdrill reader and table"
./bluewhale mdrill table feedback,feedbackred,hit,hitred,error
#./bluewhale mdrill table error,pncoerror
./bluewhale jar ./mdrill.jar com.alimama.mdrillImport.Topology feedbacktopology  feedback,feedbackred,hit,hitred,error 24 512 1000 2014030520050
#./bluewhale jar ./mdrill.jar com.alimama.mdrillImport.Topology feedbacktopology  error,pncoerror 24 512 1 2015030520050
echo -e "`date "+%Y-%m-%d %H:%M:%S"` finish the process\n\n"

exit 0
