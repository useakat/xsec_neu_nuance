#! /bin/bash

nu=$1
mares=$2

g77 combine_1pi0bg_eachEv.f
./a.out 
read nlines nfiles < nlines.dat
ncols=`expr $nfiles + 1`
sed -e "s/NLINES/${nlines}/" \
    -e "s/NFILES/${ncols}/" \
    -e 's/ C/C/' \
    -e "s/DATANAME \(.*\)line/ data (pi0bg_${nu}.ma${mares}(\1,oi),oi=1,${ncols})/" \
    -e 's/, nan,/ \//' \
    -e 's/,     nan,/ \//' < pi0bg_${nu}_ma${mares}.inc > tmp2.inc
mv tmp2.inc pi0bg_${nu}_ma${mares}.inc

rm -rf a.out tmp.inc tmp2.inc