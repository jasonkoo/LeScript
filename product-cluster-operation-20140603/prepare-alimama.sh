#! /bin/bash
cd /root/mydownload/ledrill/
mv alimama-adhoc.tar.gz.0526.cdh alimama-adhoc.tar.gz
tar -xzf alimama-adhoc.tar.gz
mv alimama /data/
cd /data/alimama/adhoc-core/bin
chmod 777 ./bluewhale
dos2unix ./bluewhale
mkdir /data/storm
mkdir /data/mdrill
