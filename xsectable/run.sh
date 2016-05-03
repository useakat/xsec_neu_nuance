#! /bin/bash
date1=`date`
mode=$1 # 1:CCQE signal 2:NCpi0bg(polfit) 3:NCpi0 4:NCpi0bg(old)
#proc=$2
nutype=$2
mail=$3

rm -rf output/*
#./main.sh $mode $proc $nutype 10000 120 0
./main.sh $mode $nutype 100000 120 0
bkill 0

date2=`date`
echo $date1
echo $date2

if [ $mail -eq 1 ];then
    bsub -q e -J xsec_table -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi