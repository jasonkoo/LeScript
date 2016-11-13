#! /bin/bash
echo "-----------------------------------------------------------------------"
cd /data/myscript/precision/
echo "#Step 1. Collect app logs"
starttime=$(date +%s)
echo "Start collecting app logs at $(date)"
./collectapplogs.sh
echo "End collecting app logs at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

echo "#Step 2. Upload app logs to HDFS"
starttime=$(date +%s) 
echo "Start uploading app logs at $(date)"
./uploadapplogs.sh
echo "End uploading app logs at $(date)"                                                                                                                                                    
endtime=$(date +%s) 
DIFF=$(( $endtime - $starttime )) 
echo "It took $DIFF seconds" 
echo

echo "#Step 3. Parse app logs"
starttime=$(date +%s) 
echo "Start parsing app logs at $(date)"
./parseapplogs.sh
echo "End parsing app logs at $(date)"                                                                                                                                                    
endtime=$(date +%s) 
DIFF=$(( $endtime - $starttime )) 
echo "It took $DIFF seconds" 
echo


echo "#Step 4. Merge app logs"
starttime=$(date +%s)
echo "Start merging app logs at $(date)"
./mergeapplogs.sh
echo "End merging app logs at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

echo "#Step 5. Tag users"
starttime=$(date +%s)
echo "Start tagging users at $(date)"
./taguser.sh
echo "End tagging users at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

echo "#Step 6. Extract user tags for solr"
starttime=$(date +%s)
echo "Start extracting user tags at $(date)"
./extracttags.sh
echo "End extracting user tags  at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

echo "#Step 7. Export users' tags to mongodb"
starttime=$(date +%s)
echo "Start exporting users' tags at $(date)"
./exporttagstomongo.sh
echo "End exporting users' tags at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

echo "#Step 8. Export users' tags to HBase"
starttime=$(date +%s)
echo "Start exporting users' tags at $(date)"
./exporttagstohbase.sh 
echo "End exporting users' tags at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

echo "#step 9. Del app logs"
./autodel.sh
