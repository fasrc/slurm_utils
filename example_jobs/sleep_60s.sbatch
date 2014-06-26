#!/usr/bin/env bash 

#SBATCH -J sleep_60s
#SBATCH -o sleep_60s.out
#SBATCH -e sleep_60s.err
#SBATCH -p general
#SBATCH -t 5
#SBATCH -n 1
#SBATCH --mem=50

sleep 60
