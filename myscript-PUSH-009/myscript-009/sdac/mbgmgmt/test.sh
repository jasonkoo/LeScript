#! /bin/bash
themonth=$(date -d yesterday "+%m")
endmonth=$(date -d yesterday "+%Y%m")
startmonth=$(( $endmonth - $themonth % 3  + 1 ))
for thismonth  in `./monthloop $startmonth $endmonth`
do
   echo $thismonth
done

startTime=$startmonth"01 00:00:00"
echo $startTime

val="a.b.c."
echo ${val%?}
