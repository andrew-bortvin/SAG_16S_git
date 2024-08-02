#!/bin/bash
#SBATCH --time=2:00:00                     
#SBATCH --nodes=1                          
#SBATCH --cpus-per-task=30
#SBATCH --partition=parallel                   
#SBATCH --account=rmccoy22

fName=`ls ../SAG_fqGz/*read2* | head -n ${SLURM_ARRAY_TASK_ID} | tail -n 1 | awk -F/ '{print $NF}'` 
fNamePrefix=`echo $fName | cut -d'_' -f1`

echo "Copying ${fName} to current directory"
cp ../SAG_fqGz/${fName} ./
gunzip ${fName}

vsearch --threads 30 --usearch_global ${fName} -db ../SILVA_db/SILVA_138.1_SSURef_NR99_CYANO_ONLY.fasta --id 0.9 --blast6out vsearch_out/${fNamePrefix}.b6

rm ${fNamePrefix}_FD_read2.fastq
rm ${fNamePrefix}_FD_read2.fasta