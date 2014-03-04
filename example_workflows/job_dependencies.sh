#!/usr/bin/env bash

# The sbatch option `--dependency' can be used to coordinate when jobs run.  
# This script shows a simple example of requiring two jobs to run in 
# non-overlapping, sequential order.  See the sbatch(1) man page for more 
# details.

# stop if any commands fail
set -e 

jobid1=$(sbatch -J job1 -o job1.out --wrap date | awk '{print $NF}')
echo "job1 is: $jobid1"

jobid2=$(sbatch -J job2 -o job2.out --dependency=afterok:"$jobid1" --wrap date | awk '{print $NF}')
echo "job2 is: $jobid2"

echo "job2 ($jobid2) should not start until job1 ($jobid1) finishes successfully"
