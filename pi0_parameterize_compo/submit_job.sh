#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: submit_job.sh [job_system] [que] [it] [jobname] [command]"
    echo ""
    exit
fi

job_system=$1
que=$2
i=$3
jobname=$4
command="$5"

dir=par_$i
mkdir $dir
cd $dir

echo "#!/bin/bash" > ajob$i
echo "#PBS -N $job" >> ajob$i
echo "rm -rf wait.ajob$i" >> ajob$i
echo "touch run.ajob$i" >> ajob$i
echo "$command" >> ajob$i
echo "rm -rf run.ajob$i" >> ajob$i
echo "touch done.ajob$i" >> ajob$i
chmod +x ajob$i
touch wait.ajob$i

if [ $job_system == "bsub" ]; then
    bsub -q $que -J $jobname ./ajob$i 1>/dev/null
fi

cd ..
