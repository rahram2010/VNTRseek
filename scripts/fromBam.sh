#!/bin/bash
# get reads from $bamfile with $proc subprocesses and pipe into $trf_exe
# dependencies: module load samtools
# dependencies: MakeBed.class, Template.class, subprocess.sh

procs=${1}
bamfile=${2}
output_dir=${3}
trf_exe=${4}
trf_param=${5}
trf_out=${6}

trap 'jobs -p | xargs kill' EXIT

# make bedfiles
samtools idxstats ${bamfile} | java MakeBedFiles ${procs} ${output_dir}

for spid in $(seq 0 $((procs-1)))
do
    #run subprocess
    ./subprocess.sh ${spid} ${bamfile} ${output_dir}/bed${spid} ${output_dir} ${trf_exe} "${trf_param}" ${trf_out} &
done

#rm -I ${output_dir}/bed*
#rm -I ${output_dir}/o.*
#rm -I ${output_dir}/e.*

while pgrep -P "$BASHPID" > /dev/null; do
  wait
done
