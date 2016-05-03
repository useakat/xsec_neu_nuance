#! /bin/bash

name=$1
input=$2
nrows=$3
output=${name}.inc
ncols=2

rm -rf $output
touch $output

echo "C/*--------------------------------------------------------" >> $output
echo "C// NC 1pi0 BG ratio table (after miss ID with polfit)" >> $output
echo "C// Enu(GeV), NC1pi0bg" >> $output
echo "C---------------------------------------------------------*/" >> $output
echo "      real*8 ${name}(${nrows},${ncols})" >> $output

i=1
while read line; do
    args=(${line})
    l1=${args[0]}
    l2=${args[1]}
    l3=${args[2]}
    r2=`echo "scale=5;${l2}/${l3}" | bc | sed 's/^\./0./'`
    echo "      data (${name}($i,oi),oi=1,${ncols}) / ${l1}, ${r2} /" >> $output
    i=`expr $i + 1`
done < $input