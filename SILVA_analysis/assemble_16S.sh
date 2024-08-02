#!/bin/bash
#SBATCH --time=1:00:00                     
#SBATCH --nodes=1                          
#SBATCH --cpus-per-task=30
#SBATCH --partition=parallel                   
#SBATCH --account=rmccoy22

ml SPAdes

fName=`ls 16S_reads | head -n ${SLURM_ARRAY_TASK_ID} | tail -n 1`
fNamePrefix=`echo ${fName} | cut -f1 -d'_'` 

mkdir spades_out/${fNamePrefix}

spades.py -t 30 -s 16S_reads/${fName} -o spades_out/${fNamePrefix} 
