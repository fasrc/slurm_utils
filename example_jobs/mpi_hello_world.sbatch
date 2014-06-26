#!/usr/bin/env bash 

#SBATCH -J mpi_hello_world
#SBATCH -o mpi_hello_world.out
#SBATCH -e mpi_hello_world.err
#SBATCH -p general
#SBATCH -t 5
#SBATCH -n 3
#SBATCH -N 2
#SBATCH --mem=50

mpirun -np 3 ./mpi_hello_world
