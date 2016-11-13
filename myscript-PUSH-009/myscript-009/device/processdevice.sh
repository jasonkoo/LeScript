#! /bin/bash
echo "-----------------------------------------------------------------------"
part=domestic
cd  /data/myscript/device
echo "#Step 1. Import $part device attributes from mongodb"
starttime=$(date +%s)
echo "Start importing $part device attributes at $(date)"
./importdevice.sh $part
echo "End importing $part device attributes at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

echo "#Step 2. Merge $part device attributes"
starttime=$(date +%s) 
echo "Start merging $part device attributes at $(date)"
./mergedevice.sh $part
echo "End merging $part device attributes at $(date)" 
endtime=$(date +%s) 
DIFF=$(( $endtime - $starttime )) 
echo "It took $DIFF seconds" 
echo

echo "#Step 3. Extract $part device attributes for solr"
starttime=$(date +%s)
echo "Start extracting $part device attributes at $(date)"
./extractdevice.sh $part
echo "End extracting $part device attributes at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

echo "#Step 4. Join $part device attributes with device tags"
starttime=$(date +%s)
echo "Start joining $part device attributes with tags at $(date)"
./joindevice.sh $part 
echo "End joining $part device attributes with tags at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

echo "#Step 5. Index $part  device attributes and tags"
starttime=$(date +%s)
echo "Start indexing $part device attributes and tags at $(date)"
./indexdevice.sh $part
echo "End indexing $part device attributes and tags at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

part=overseas
echo "#Step 6. Import $part device attributes from mongodb"
starttime=$(date +%s)
echo "Start importing $part device attributes at $(date)"
./importdevice.sh $part
echo "End importing $part device attributes at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

echo "#Step 7. Merge $part device attributes"
starttime=$(date +%s) 
echo "Start merging $part device attributes at $(date)"
./mergedevice.sh $part
echo "End merging $part device attributes at $(date)" 
endtime=$(date +%s) 
DIFF=$(( $endtime - $starttime )) 
echo "It took $DIFF seconds" 
echo

echo "#Step 8. Extract $part device attributes for solr"
starttime=$(date +%s)
echo "Start extracting $part device attributes at $(date)"
./extractdevice.sh $part
echo "End extracting $part device attributes at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

echo "#Step 9. Join $part device attributes with device tags"
starttime=$(date +%s)
echo "Start joining $part device attributes with tags at $(date)"
./joindevice.sh $part
echo "End joining $part device attributes with tags at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo

echo "#Step 5. Index $part  device attributes and tags"
starttime=$(date +%s)
echo "Start indexing $part device attributes and tags at $(date)"
./indexdevice.sh $part
echo "End indexing $part device attributes and tags at $(date)"
endtime=$(date +%s)
DIFF=$(( $endtime - $starttime ))
echo "It took $DIFF seconds"
echo
