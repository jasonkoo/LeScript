#! /bin/bash
ping -i 5 psb-la-vm04 | while read pong; 
do 
    rtt=$(echo $pong | awk '{print $8}' | cut -d'=' -f2)
    echo -e "$(date +%H:%M:%S)\t$rtt"  >> /data/myscript/ping/logs/ping-monitor.$(date +%Y%m%d)
done 
