#! /bin/bash
selfdir=$(cd $(dirname $0);pwd)
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: get_datatable.sh [run_name] [ixsec] [xsec_mode] [dist_mode] [proc] [nutype] [mail]"
    echo ""
    echo "xsec mode: 1:CCQE signal 2:NCpi0 BG(polfit) 3:NCpi0 4:NCpi0 BG(old) 5:Others"
    echo "dist mode: 0: None 1: Erec 2: mom"
    echo "proc: all/ncrs/ncco/ncdi/ncqe"
    echo ""
    exit
fi

if [[ $1 = "" ]]; then
    echo "run name"
    read run
    echo "xsec switch"
    read ixsec
    echo "xsec mode"
    read xsec_mode
    echo "dist mode"
    read dist_mode
    echo "proc"
    read proc
    echo "nutype"
    read nutype
    echo "mail"
    read mail
else
run=$1
ixsec=$2
xsec_mode=$3
dist_mode=$4
proc=$5
nutype=$6
mail=$7
fi    

#dist_mode2 =  0: None 1:NCpBG(polfit) Erec 2:NCpi0 mom 3:NCpi0BG(old) Erec 4:NCpi0 Erec 5:NCpi0(1-polfit) 
if [ $xsec_mode -eq 1 ];then
    dist_mode2=0
elif [ $xsec_mode -eq 2 ];then
    if [ $dist_mode -eq 0 ];then
	dist_mode2=0
    elif [ $dist_mode -eq 1 ];then
	dist_mode2=1
    elif [ $dist_mode -eq 2 ];then
	echo "Sorry, NCpi0 BG(polfit) mom is not available yet."
        echo "Exitting Program..."
	exit
    fi
elif [ $xsec_mode -eq 3 ];then	
    if [ $dist_mode -eq 0 ];then
	dist_mode2=0
    elif [ $dist_mode -eq 1 ];then
	dist_mode2=4
    elif [ $dist_mode -eq 2 ];then
	dist_mode2=2
    fi	
elif [ $xsec_mode -eq 4 ];then	
    if [ $dist_mode -eq 0 ];then
	dist_mode2=0
    elif [ $dist_mode -eq 1 ];then
	dist_mode2=3
    elif [ $dist_mode -eq 2 ];then
	echo "Sorry, NCpi0 BG(old) mom is not available yet."
        echo "Exitting Program..."
	exit
    fi	
elif [ $xsec_mode -eq 5 ];then	
    if [ $dist_mode -eq 0 ];then
	dist_mode2=0
    elif [ $dist_mode -eq 1 ];then
	dist_mode2=5
    elif [ $dist_mode -eq 2 ];then
	echo "Sorry, NCpi0 BG(1-polfit) mom is not available yet."
        echo "Exitting Program..."
	exit
    fi	
fi

echo ""
echo `date`
echo $0 $1 $2 $3 $4

outdir=xsec_$run
if [ -e $outdir ];then
#    rm -rf $outdir/*
    nothing=3
else
    mkdir $outdir
fi

#if [ $ixsec -ne 0 ];then
    echo""
    echo "Making Cross section Table"
    cd xsectable
#    ./run.sh $xsec_mode $proc 0
    ./run.sh $xsec_mode $nutype 0
    cp -rf output/* ../$outdir/.
    cd ..
#fi

if [ $dist_mode2 -ne 0 ];then
    echo ""
    echo "Making NC-pi0 distribution Table"
    cd pi0_parameterize
    ./run.sh $dist_mode2 $proc $nutype 0
    cp -rf output/* ../$outdir/.
fi

echo "Finished!"
echo `date`

if [ $mail -eq 1 ];then
    bsub -q e -J data_table -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi
