#! /bin/bash
# pass startmonth as the first argument of this script 
# by default, current month is the endmonth

function monthdiff(){
sy=$(echo $1 | cut -c1-4)
sm=$(echo $1 | cut -c5-6)
ey=$(echo $2 | cut -c1-4)
em=$(echo $2 | cut -c5-6)
echo $(( ( $ey - $sy ) * 12 + ( 10#$em - 10#$sm ) ))
}

mp=%Y%m

st=$1
startdate='01'
startdate=$st$startdate

if [ -n "$2" ] ; then
  ed=$2
else
  ed=$(date -d "0 months ago" +$mp)
fi

diff=$(monthdiff $st $ed)
for (( c=0; c<=$diff; c++ ))
do
    themonth=$(date -d "$startdate +$c month" +$mp)
    echo $themonth
done
