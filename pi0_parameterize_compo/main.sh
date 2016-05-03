#! /bin/bash
selfdir=$(cd $(dirname $0);pwd)
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: main.sh [mode] [proc] [nu] [Enu] [nevnet]"
    echo "mode 1:Erec polfit 2:mom pi0 3:Erec old 4:Erec pi0 5:Erec 1-polfit"
    echo "proc all/ncrs/ncco/ncdi/ncqe"
    echo ""
    exit
fi

if [[ $1 = "" ]]; then
    echo "mode"
    read mode
    echo "proc"
    read proc
    echo "nu"
    read nu
    echo "Enu"
    read Enu
    echo "nevent"
    read nevent
#    echo "ma(res)"
#    read ma
else
    mode=$1
    proc=$2
    nu=$3
    Enu=$4
    nevent=$5
#    ma=$5
fi
#fnevnt=-year
fnevnt=-nevt
#seed=$RANDOM
seed=12345
if [ $nu == "ne" ]; then
    ncode=12
elif [ $nu == "ae" ]; then
    ncode=-12
elif [ $nu == "nm" ]; then
    ncode=14
elif [ $nu == "am" ]; then
    ncode=-14
fi
if [ $mode -eq 1 ];then # pi0 Erec dist after 1pi0cut & polfit missID
#    run=${nu}${Enu}_${ma}
    run=${nu}${Enu}_1100
    if [ $proc == "all" ];then
	kumac=erec_table
    else
	kumac=pi0_erec_${proc}_polfit_table
    fi
elif [ $mode -eq 2 ];then
#    run=pi0mom_${nu}${Enu}_${ma}
    run=pi0mom_${nu}${Enu}_1100

    kumac=pi0mom_table
#    kumac=pi0mom_table_corr2re
#    run=pi0mom_old_${nu}${Enu}_${ma}
#    kumac=pi0mom_old_table
elif [ $mode -eq 3 ];then # pi0 Erec dist after 1pi0cut & old missID
#    run=erec_old_${nu}${Enu}_${ma}
    run=erec_old_${nu}${Enu}_1100

    kumac=erec_old_table
#    kumac=erec_old_table_corr2re
elif [ $mode -eq 4 ];then # pi0 Erec dist after 1pi0cut
#    run=pi0_erec_${nu}${Enu}_${ma}
    run=pi0_erec_${nu}${Enu}_1100
    if [ $proc == "all" ];then
	kumac=pi0_erec_table
    else
	kumac=pi0_erec_${proc}_table
    fi
elif [ $mode -eq 5 ];then # pi0 Erec dist after 1pi0cut & (1 -polfit)
    run=${nu}${Enu}_1100
    if [ $proc == "all" ];then
	kumac=pi0_erec_invpol_table
    else
	kumac=pi0_erec_invpol_${proc}_table
    fi
fi

output=${run}.inc
cp -rf ${selfdir}/temp/* .
#sed -e "s/MARES/${ma}/" < nuance_defaults.cards > nuance_defaults.tmp
#mv nuance_defaults.tmp nuance_defaults.cards
#sed -e "s/MARES/${ma}/" < nuance_defaults_nc.cards > nuance_defaults.cards
mv nuance_defaults_nc.cards nuance_defaults.cards

#cp -rf /gpfs/home/th/takaesu/projects/T2KK/nuance_sample_cards/nuance_defaults.cards ${selfdir}/defaults
#nuanceMc.exe -mono $ncode $Enu $fnevnt $3 -r $seed -h ${1}${2}_1030_1100.hbk ! > ${1}${2}_1030_1100.log
nuanceMc.exe -mono $ncode $Enu $fnevnt $nevent -r $seed -h ${run}.hbk ! > ${run}.log
#nuanceMc.exe -mono $ncode $Enu $fnevnt $3 -r $seed -nopn -h ${1}${2}_qe_1030_1100.hbk ! > ${1}${2}_qe_1030_1100.log

mv ${run}.hbk tmp.hbk
paw -b $kumac

rm -rf $output
touch $output
echo "C/*--------------------------------------------------------" >> $output
echo "C// 1pi0-bg Erec distribution  table" >> $output
echo "C// Erec(GeV),NCQE,NCRS,NCDI,NCCO+NCDF,Total" >> $output
echo "C/--------------------------------------------------------*" >> $output
echo "      real*8 ${run}(NLINES,6)" >> $output
i=1
while read x NCQE NCRS NCDI NCCO TOT; do
    echo "      data (${run}(${i},oi),oi=1,6) / ${x}, ${NCQE}, ${NCRS}, ${NCDI}, ${NCCO}, ${TOT} /" >> $output
    i=`expr $i + 1`
done < tmp.dat
nlines=`expr $i - 1`
sed -e "s/NLINES/${nlines}/" $output > tmp2.dat
mv tmp2.dat $output

rm -rf tmp.hbk
