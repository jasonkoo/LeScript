#! /bin/bash
homeDir=$(cd "$(dirname "$0")"; pwd)
echo "###################################$(date +%Y%m%d)########################################"
echo "pushmarketing => feedback"
startSecs=$(date +%s)
$homeDir/pushmarketing/feedback.sh
endSecs=$(date +%s)
secsDiff=$(( $endSecs - $startSecs ))
echo "Time taken $secsDiff seconds"

echo

#echo "pushmarketing => error"
#startSecs=$(date +%s)
#$homeDir/pushmarketing/error.sh
#endSecs=$(date +%s)
#secsDiff=$(( $endSecs - $startSecs ))
#echo "Time taken $secsDiff seconds"

#echo

#echo "fake => feedback"
#startSecs=$(date +%s)
#$homeDir/fake/feedback.sh
#endSecs=$(date +%s)
#secsDiff=$(( $endSecs - $startSecs ))
#echo "Time taken $secsDiff seconds"

#echo 

#echo "fake => error"
#startSecs=$(date +%s) 
#$homeDir/fake/error.sh
#endSecs=$(date +%s)
#secsDiff=$(( $endSecs - $startSecs ))
#echo "Time taken $secsDiff seconds" 

#echo

#echo "openplatform => feedback"
#startSecs=$(date +%s) 
#$homeDir/openplatform/feedback.sh
#endSecs=$(date +%s)                                                                                                                                                                           
#secsDiff=$(( $endSecs - $startSecs ))
#echo "Time taken $secsDiff seconds" 

#echo

#echo "openplatform => error"
#startSecs=$(date +%s)
#$homeDir/openplatform/error.sh
#endSecs=$(date +%s)
#secsDiff=$(( $endSecs - $startSecs ))
#echo "Time taken $secsDiff seconds"

#echo
