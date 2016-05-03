#!/bin/bash

x=$1
scale=$2

r=${x%%E*}
if [ $r != $x ];then
    epm=${x##*E}    
    e=${epm##+}
    e=${e##-}
    pm=${epm%%${e}}
    
    if [ ${pm} == "+" ]; then
	base=10
    elif [ ${pm} == "-" ]; then
	base=0.1
    fi
    
    echo "scale=${scale}; ${r}*${base}^(${e})" | bc | sed -e 's/^\./0./'
else
    echo $x
fi    