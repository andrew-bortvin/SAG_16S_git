#!/bin/bash
#SBATCH --time=1:00:00                     
#SBATCH --nodes=1                          
#SBATCH --cpus-per-task=4
#SBATCH --partition=parallel                   
#SBATCH --account=rmccoy22

fName=`ls ../SAG_fqGz/*read2* | head -n ${SLURM_ARRAY_TASK_ID} | tail -n 1 | awk -F/ '{print $NF}'` 
fNamePrefix=`echo $fName | cut -d'_' -f1`

cut -f1 vsearch_out/${fNamePrefix}.b6 | grep -A3 -f - ${fNamePrefix}_FD_read2.fastq | awk '!/--/' > 16S_reads/${fNamePrefix}_16S.fastq

rm ${fNamePrefix}_FD_read2.fastq
rm ${fNamePrefix}_FD_read2.fasta