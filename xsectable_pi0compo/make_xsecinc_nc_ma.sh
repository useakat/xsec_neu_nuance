#! /bin/bash

name=$1
input=$2
nrows=$3
mode=$4
output=${name}.inc
ncols=10

rm -rf $output
touch $output

echo "C/*--------------------------------------------------------" >> $output
if [ $mode -eq 2 ];then
    echo "C// NC 1pi0 BG ratio table (after miss ID with polfit)" >> $output
elif [ $mode -eq 3 ];then
    echo "C// NC 1pi0 ratio table" >> $output
fi
echo "C// Enu(GeV), NC1pi0bg" >> $output
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
    l7=${args[6]}
    l8=${args[7]}
    l9=${args[8]}
    l10=${args[9]}
    echo "      data (${name}($i,oi),oi=1,${ncols}) / ${l1}, ${l2}, ${l3}, ${l4}, ${l5}, ${l6}, ${l7}, ${l8}, ${l9}, ${l10} /" >> $output
    i=`expr $i + 1`
done < $input