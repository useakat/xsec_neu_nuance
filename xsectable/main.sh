#! /bin/bash
#####################################################
# This script makes ratio table of neutrino-nucleus
# interaction modes, using Nuance.
#
# Yoshitaro Takaesu2013/Oct/12 @KIAS
#####################################################
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: run.sh [mode] [proc] [nu] [years] [nrows] [mail]"
    echo ""
    echo "mode 1:CCQE 2:NCpi0/e(polfit) 3:NC1pi0 4:NCpi0/e(old)"
    echo "proc all/ncrs/ncco/ncdi/ncqe"
    exit
fi
selfdir=$(cd $(dirname $0);pwd)
# variables
mode=2
#proc=all
nu=nm
#years=100
nevent=100000
nrows=120
mail=1
if [[ $1 = "h" ]]; then
    echo "mode? 1:CCQE 2:NCpi0/e(polfit) 3:NC1pi0 4:NCpi0/e(old)"
    read mode
    echo "Process? all/ncrs/ncco/ncdi/ncqe"
#    read proc
#    echo "nu? nm/ne/am/ae"
    read nu
    echo "nevent?"
    read nevent
    echo "rows?"
    read nrows
    echo "mail?"
    read mail
else
    if [ $# -ge 1 ];then
	mode=$1
    fi
#    if [ $# -ge 2 ];then
#	proc=$2
#    fi
    if [ $# -ge 2 ];then
	nu=$2
    fi
    if [ $# -ge 3 ];then
	nevent=$3
    fi
    if [ $# -ge 4 ];then
	nrows=$4
    fi
    if [ $# -ge 5 ];then
	mail=$5
    fi
fi   
cluster=kekcc
job_system=bsub
#que=e # For jobs < 10 min
que=s # For jobs < 3 hours
#que=l # For jobs < 24 hours
#que=h # For heavy jobs
######################
if [ $nu == "ne" ];then
    nucode=12
elif [ $nu == "nm" ];then
    nucode=14
elif [ $nu == "ae" ];then
    nucode=-12
elif [ $nu == "am" ];then
    nucode=-14
fi
if [ $mode -eq 1 ];then
    run=${nu}_CCxsec
    incfile=${nu}_ratioCC
elif [ $mode -eq 2 ];then
    run=${nu}_NCxsec
    incfile=${nu}_ratioNC
elif [ $mode -eq 3 ];then
    run=${nu}_NCxsec_1pi0
    incfile=${nu}_ratioNC_1pi0
elif [ $mode -eq 4 ];then
    run=${nu}_NCxsec_old
    incfile=${nu}_ratioNC_old
elif [ $mode -eq 5 ];then
    run=${nu}_NCxsec
    incfile=${nu}_ratioNC
fi

log=log.log
output=${run}.dat

start_time=`date '+%s'`
echo `date '+%T'`
echo $run

rm -rf ${incfile}.inc
rm -rf $output
touch $output
echo "Starting... $nu $nevent $output" 

i=0
#nrows=10
while [ $i -lt $nrows ];do
    E=`echo "scale=5; 25 +50*$i" | bc`
    jobname=submit$i
#    ./submit_job.sh $job_system $que $i $jobname "../gen_xsec.sh $nu $E $nevent $output"
#    ./submit_job.sh $job_system $que $i $jobname "../gen_xsec_all.sh $nu $E $nevent $output"
    if [ $mode -eq 1 ];then # For CC signal
#	./submit_job.sh $job_system $que $i $jobname "../gen_xsec_ccres_h2o.sh ${nucode} $E $nevent $output"
#	./submit_job.sh $job_system $que $i $jobname "../gen_xsec_cc_h2o.sh ${nucode} $E $nevent $output"
	./submit_job.sh $job_system $que $i $jobname "../gen_xsec_cc_h2o_compo.sh ${nucode} $E $nevent $output"
    elif [ $mode -ne 1 ];then # For NC pi0
#    ./submit_job.sh $job_system $que $i $jobname "../gen_xsec_nc_h2o_ma.sh ${nucode} $E $nevent $output ${mode}"
#	./submit_job.sh $job_system $que $i $jobname "../gen_xsec_nc_h2o_ma2.sh ${nucode} $E $nevent $output ${mode}"
	./submit_job.sh $job_system $que $i $jobname "${selfdir}/gen_xsec_nc_h2o_compo.sh ${nucode} $E $nevent $output ${mode}"
    fi
    i=`expr $i + 1`
done
n=$i
./monitor
i=0
while [ $i -lt $n ]; do
    cat par_${i}/$output >> $output
    i=`expr $i + 1`
done
if [ -e output ];then
    a=3
else
    mkdir output
fi
cp -rf par_0/nuance_defaults.cards output/.

rm -rf par_*

if [ $mode -eq 1 ];then # For CC signal
#    ./make_xsecinc.sh $incfile $output $nrows
    ./make_xsecinc_CCQEbase.sh $incfile $output $nrows
elif [ $mode -ne 1 ];then # For NC pi0
#    ./make_xsecinc_nc_ma.sh $incfile $output $nrows $mode
    ./make_xsecinc_nc_compo.sh $incfile $output $nrows $mode
fi

cp -rf ${incfile}.inc output/.

if [ $mail -eq 1 ]; then
    bsub -q e -J $run -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi