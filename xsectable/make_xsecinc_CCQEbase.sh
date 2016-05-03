#! /bin/bash

name=$1
input=$2
nrows=$3
output=${name}.inc
output2=${name}.inc.dat
ncols=5

rm -rf $output
rm -rf $output2
touch $output
touch $output2

echo "C/*--------------------------------------------------------" >> $output
echo "C// Anti-electron neutrino ratio (w.r.t. NUANCE-CCQE) table for interaction modes" >> $output
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
    if [ $l6 -ne 0 ];then
	r2=`echo "scale=5;${l2}/${l6}" | bc | sed 's/^\./0./'`
	r3=`echo "scale=5;${l3}/${l6}" | bc | sed 's/^\./0./'`
	r4=`echo "scale=5;${l4}/${l6}" | bc | sed 's/^\./0./'`
	r5=`echo "scale=5;${l5}/${l6}" | bc | sed 's/^\./0./'`
    else
	r2=0
	r3=0
	r4=0
	r5=0
    fi
    echo "      data (${name}($i,oi),oi=1,${ncols}) / ${l1}, ${r2}, ${r3}, ${r4}, ${r5} /" >> $output
    echo "${l1} ${r2} ${r3} ${r4} ${r5}" >> $output2
    i=`expr $i + 1`
done < $input