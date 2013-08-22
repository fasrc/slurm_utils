#!/bin/bash

joblist=$(squeue -u $1 | awk '{if ($5 =="R"){print $1}}')

for j in $joblist
do
	scontrol suspend $j
done

