#! /bin/bash
src=$1
dst=$2
hosts=(1 2 3 4 5 6 7 8 14 15 16 17)
#for i in {1..20}
for i in ${hosts[@]}
do
    if [ $i -lt 10 ]; then    
      scp -P 22222 -r $src PUSH-00$i:~/$dst
    else
      scp -P 22222 -r $src PUSH-0$i:~/$dst
    fi 
done
