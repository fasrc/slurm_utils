#!/usr/bin/env bash 

#SBATCH -J hello_world
#SBATCH -o hello_world.out
#SBATCH -e hello_world.err
#SBATCH -p general
#SBATCH -t 5
#SBATCH -n 1
#SBATCH --mem=50

echo "Hello, World!"
