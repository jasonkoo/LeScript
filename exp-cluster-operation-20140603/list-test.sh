#! /usr/bin/expect -f
set timeout 20
set hosts {01 02 03 04 05 06 07 08 14 15 16 17}
foreach host $hosts {
   puts "$host"
}
