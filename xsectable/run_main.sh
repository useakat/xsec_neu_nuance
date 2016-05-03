#! /bin/bash
#####################################################
# This script makes ratio table of neutrino-nucleus
# interaction modes, using Nuance.
#
# Yoshitaro Takaesu2013/Oct/12 @KIAS
#####################################################
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: run.sh [nu] [years] [nrows] [mail]"
    echo ""
    exit
fi
selfdir=$(cd $(dirname $0);pwd)
# variables
nu=nm
years=100
nrows=120
mail=1
if [[ $1 = "h" ]]; then
    echo "nu? nm/ne/am/ae"
    read run
    echo "years?"
    read years
    echo "rows?"
    read nrows
    echo "mail?"
    read mail
else
    if [ $# -ge 1 ];then
	nu=$1
    fi
    if [ $# -ge 2 ];then
	years=$2
    fi
    if [ $# -ge 3 ];then
	nrows=$3
    fi
    if [ $# -ge 4 ];then
	mail=$4
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
run=${nu}_NCxsec
incfile=${nu}_ratioNC
log=log.log
output=${run}.dat

start_time=`date '+%s'`
echo `date '+%T'`
echo $run

rm -rf $output
touch $output
echo "Starting... $nu $years $output" 

i=0
while [ $i -lt $nrows ];do
    E=`echo "scale=5; 25 +50*$i" | bc`
    jobname=$RANDOM
#    ./submit_job.sh $job_system $que $i $jobname "../gen_xsec.sh $nu $E $years $output"
#    ./submit_job.sh $job_system $que $i $jobname "../gen_xsec_all.sh $nu $E $years $output"
## For CC signal
#    ./submit_job.sh $job_system $que $i $jobname "../gen_xsec_ccres_h2o.sh ${nucode} $E $years $output"
## For NC 1pi0 bg
    ./submit_job.sh $job_system $que $i $jobname "../gen_xsec_nc_h2o.sh ${nucode} $E $years $output"
    i=`expr $i + 1`
done
n=$i
./monitor
i=0
while [ $i -lt $n ]; do
    cat par_${i}/$output >> $output
    i=`expr $i + 1`
done

rm -rf par_*

#./make_xsecinc.sh $incfile $output $nrows # for CC signal
./make_xsecinc_nc.sh $incfile $output $nrows # for NC 1pi0bg

if [ $mail -eq 1 ]; then
    bsub -q e -J $run -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi