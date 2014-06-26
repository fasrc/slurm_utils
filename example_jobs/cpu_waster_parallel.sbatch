#!/usr/bin/env bash 

#SBATCH -J cpu_waster_parallel
#SBATCH -o cpu_waster_parallel.out
#SBATCH -e cpu_waster_parallel.err
#SBATCH -p general
#SBATCH -t 5
#SBATCH -n 3
#SBATCH -N 2
#SBATCH --mem=50

mpirun -np 3 ./cpu_waster_parallel
