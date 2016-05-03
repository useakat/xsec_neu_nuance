#! /bin/bash

name=$1
input=$2
nrows=$3
output=${name}.inc
ncols=5

rm -rf $output
touch $output

echo "C/*--------------------------------------------------------" >> $output
echo "C// Anti-electron neutrino ratio table for interaction modes" >> $output
echo "C// Enu(GeV), CCQE-H, CCQE-O, RES-H, RES-O" >> $output
echo "C---------------------------------------------------------*/" >> $output
echo "      real*8 ${name}(${nrows},${ncols})" >> $output

i=1
while read line; do
    args=(${line})
    l1=${args[0]}
    l2=${args[1]}
    l3=${args[2]}
    l4=${args[3]}
    l5=${args[4]}
    l6=${args[5]}
    echo "      data (${name}($i,oi),oi=1,${ncols}) / ${l1}, ${l2}, ${l3}, ${l4}, ${l5} /" >> $output
    i=`expr $i + 1`
done < $input