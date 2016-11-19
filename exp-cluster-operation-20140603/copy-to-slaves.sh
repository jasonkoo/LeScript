#! /bin/bash
src=$1
dst=$2
for i in {1..3}
do
    scp -r $src root@cma0$i:~/$2 
done
