#! /bin/bash
selfdir=$(cd $(dirname $0);pwd)
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: main.sh [mode] [nu] [Enu] [nevnet] [ma]"
    echo "mode 1:Erec polfit 2:pi0mom 3:Erec old"
    echo ""
    exit
fi

if [[ $1 = "" ]]; then
    echo "mode"
    read mode
    echo "nu"
    read nu
    echo "Enu"
    read Enu
    echo "nevent"
    read nevent
    echo "ma(res)"
    read ma
else
    mode=$1
    nu=$2
    Enu=$3
    nevent=$4
    ma=$5
fi
#fnevnt=-year
fnevnt=-nevt
seed=$RANDOM
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
    run=${nu}${Enu}_${ma}
    kumac=erec_table
elif [ $mode -eq 2 ];then
#    run=pi0mom_${nu}${Enu}_${ma}
#    kumac=pi0mom_table
    run=pi0mom_old_${nu}${Enu}_${ma}
    kumac=pi0mom_old_table
elif [ $mode -eq 3 ];then # pi0 Erec dist after 1pi0cut & old missID
    run=erec_old_${nu}${Enu}_${ma}
    kumac=erec_old_table
elif [ $mode -eq 4 ];then # pi0 Erec dist after 1pi0cut
    run=pi0_erec_${nu}${Enu}_${ma}
#    kumac=pi0_erec_table
#    kumac=pi0_erec_table
fi

output=${run}.inc
cp -rf ${selfdir}/temp/* .

sed -e "s/MARES/${ma}/" < nuance_defaults.cards_ma > nuance_defaults.tmp
mv nuance_defaults.tmp nuance_defaults.cards
#cp -rf /gpfs/home/th/takaesu/projects/T2KK/nuance_sample_cards/nuance_defaults.cards ${selfdir}/defaults
#nuanceMc.exe -mono $ncode $Enu $fnevnt $3 -r $seed -h ${1}${2}_1030_1100.hbk ! > ${1}${2}_1030_1100.log
#nuanceMc.exe -mono $ncode $Enu $fnevnt $3 -r $seed -nopn -h ${1}${2}_qe_1030_1100.hbk ! > ${1}${2}_qe_1030_1100.log
nuanceMc.exe -mono $ncode $Enu $fnevnt $nevent -r $seed -h tmp.hbk ! > ${run}.log


proc="'NCQE'"
kumac=pi0_erec_ncqe_table
sed -e "s/NNNEVENTS/${nevent}/" < ${kumac}.kumac_temp > ${kumac}.kumac
paw -b $kumac
mv tmp.dat ncqe.dat

proc="'NCRS'"
kumac=pi0_erec_ncrs_table
sed -e "s/NNNEVENTS/${nevent}/" < ${kumac}.kumac_temp > ${kumac}.kumac
paw -b $kumac
mv tmp.dat ncrs.dat

proc="'NCCO'"
kumac=pi0_erec_ncco_table
sed -e "s/NNNEVENTS/${nevent}/" < ${kumac}.kumac_temp > ${kumac}.kumac
paw -b $kumac
mv tmp.dat ncco.dat

proc="'NCDI'"
kumac=pi0_erec_ncdi_table
sed -e "s/NNNEVENTS/${nevent}/" < ${kumac}.kumac_temp > ${kumac}.kumac
paw -b $kumac
mv tmp.dat ncdi.dat

kumac=pi0_erec2_table
sed -e "s/NNNEVENTS/${nevent}/" < ${kumac}.kumac_temp > ${kumac}.kumac
paw -b $kumac
mv tmp.dat total.dat

g77 combine_ncproc.f
./a.out
 rm -rf $output
 touch $output
sed -e "s/ARRAY/${run}/" tmp.inc > tmp2.inc

 echo "C/*--------------------------------------------------------" >> $output
 echo "C// 1pi0-bg Erec distribution  table" >> $output
 echo "C// Erec(GeV), NCQE NCRS NCCO NCDI" >> $output
 echo "C/--------------------------------------------------------*" >> $output
cat tmp2.inc >> $output
# echo "      real*8 ${run}(NLINES,2)" >> $output
# i=1
# while read x y; do
#     echo "      data (${run}(${i},oi),oi=1,2) / ${x}, ${y} /" >> $output
#     i=`expr $i + 1`
# done < tmp.dat
# nlines=`expr $i - 1`
# sed -e "s/NLINES/${nlines}/" $output > tmp2.dat
# mv tmp2.dat $output

rm -rf tmp.hbk
