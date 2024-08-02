#!/bin/bash
#SBATCH --time=2:00:00                     
#SBATCH --nodes=1                          
#SBATCH --cpus-per-task=30
#SBATCH --partition=parallel                   
#SBATCH --account=rmccoy22

ml SPAdes

fName=`ls 16_S_reads_cleaned | head -n ${SLURM_ARRAY_TASK_ID} | tail -n 1`
fNamePrefix=`echo ${fName} | cut -f1 -d'_'` 

mkdir spades_out/${fNamePrefix}

spades.py -t 30 -s 16_S_reads_cleaned/${fName} -o spades_out/${fNamePrefix} 
