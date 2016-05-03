#! /bin/bash
selfdir=$(cd $(dirname $0);pwd)
if [[ "$1" == "-h" ]]; then
    echo ""
#    echo "Usage: run_parallel.sh [mode] [nu] [ma] [nevnet]"
    echo "Usage: run_parallel.sh [mode] [proc] [nu] [nevnet] [mail]"
    echo "mode: 1:NCpi0 Erec (Polfit) 2:NCpi0 mom 3:NCpi0 Erec (old) 4:NCpi0 Erec 5:NCpi0 Erec (1-polfit)"
    echo "proc all/ncrs/ncco/ncdi/ncqe"
    exit
fi

if [[ $1 = "" ]]; then
    echo "mode"
    read mode
    echo "proc"
    read proc
    echo "nu"
    read nu
#    echo "ma(res)"
#    read ma
    echo "nevent"
    read nevent
    echo "mail"
    read mail
else
    mode=$1
    proc=$2
    nu=$3
#    mares=$3
#    nevent=$4
#    mail=$5
    nevent=$4
    mail=$5
fi    
Enumin=200 # Enumin < 100 MeV is almost nothing.
Enumax=6000
dEnu=100
run=1pi0bk
cluster=kekcc
job_system=bsub
#que=e # For jobs < 10 min
que=s # For jobs < 3 hours
#que=l # For jobs < 24 hours
#que=h # For heavy jobs
######################
nn=`echo "scale=5; (${Enumax} -${Enumin})/${dEnu} +1" | bc | cut -d. -f1`
#echo $nu $mares $Enumin $dEnu $nn > setting.dat
echo $nu $Enumin $dEnu $nn > setting.dat

i=0
while [ $i -lt $nn ];do
    Enu=`expr $Enumin + ${dEnu} \* ${i}`
    jobname=$RANDOM
    if [ $mode -ne 4 ];then
#	./submit_job.sh $job_system $que $i $jobname "../main.sh $mode $nu $Enu $nevent $mares"
	./submit_job.sh $job_system $que $i $jobname "../main.sh $mode $proc $nu $Enu $nevent"
    elif [ $mode -eq 4 ];then
#	./submit_job.sh $job_system $que $i $jobname "../main_proc.sh $mode $nu $Enu $nevent $mares"
#	./submit_job.sh $job_system $que $i $jobname "../main.sh $mode $nu $Enu $nevent $mares"
	./submit_job.sh $job_system $que $i $jobname "../main.sh $mode $proc $nu $Enu $nevent"
    fi
    i=`expr $i + 1`
done
n=$i
./monitor
rm -rf 1pi0bg_table
mkdir 1pi0bg_table
i=0
while [ $i -lt $n ]; do
    cp -rf par_${i}/*.inc 1pi0bg_table/.
    i=`expr $i + 1`
done
cp -rf par_1/nuance_defaults.cards 1pi0bg_table/.
rm -rf 1pi0bg_table/funcs.inc 1pi0bg_table/selectcut*

#./make_1pi0bg_table_eachEv.sh $nu $mares
#./make_1pi0bg_table.sh $nu $mares

rm -rf par_*

if [ $mail -eq 1 ]; then
    bsub -q e -J $run -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi