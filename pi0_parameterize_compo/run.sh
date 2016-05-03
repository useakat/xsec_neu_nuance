#! /bin/bash
# "mode: 1:NCpi0 Erec (Polfit) 2:NCpi0 mom 3:NCpi0 Erec (old) 4:NCpi0 Erec 5:NCpi0 Erec (1-polfit)
mode=$1
proc=$2
mail=$3

if [ $mode -eq 1 ];then
type=pi0bg
elif [ $mode -eq 2 ];then
type=pi0mom
elif [ $mode -eq 3 ];then
type=pi0_Erec_old
elif [ $mode -eq 4 ];then
type=pi0_Erec
elif [ $mode -eq 5 ];then
type=pi0bg
fi

outdir=output
if [ -e $outdir ];then
    rm -rf $outdir/*
else
    mkdir $outdir
fi

dir=nm_$type
rm -rf $dir
#./run_parallel.sh $mode nm 1100 1000000 0
./run_parallel.sh $mode $proc nm 10000 0
cp -rf 1pi0bg_table $dir
cp -rf $dir $outdir/.

# dir=am_$type
# rm -rf $dir
# #./run_parallel.sh $mode am 1100 1000000 0
# ./run_parallel.sh $mode $proc am 100000 0
# cp -rf 1pi0bg_table $dir
# cp -rf $dir $outdir/.

if [ $mail -eq 1 ];then
    bsub -q e -J pi0_param -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi