#! /bin/bash
homeDir=$(cd "$(dirname "$0")"; pwd)
echo "-----------------------------------------------------------------------"
echo "#Step 1. import feedback device attributes"
starttime=$(date +%s)
echo "Start importing feedback device attributes at $(date)"
$homeDir/import-feedback.sh
echo "End importing feedback device attributes at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

echo "#Step 2. dimstat feedback"
starttime=$(date +%s)
echo "Start dimstating feedback at $(date)"
$homeDir/dimstat-feedback.sh
echo "End dimstating feedback at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

