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

echo "Converting to fastq"
sed -n '1~4s/^@/>/p;2~4p' ${fNamePrefix}_FD_read2.fastq  > ${fNamePrefix}_FD_read2.fasta
sed -i 's/ /_/g' ${fNamePrefix}_FD_read2.fasta

echo "BLASTing ${fNamePrefix}"

../blastn -db ../BLAST_16S_db/16S_ribosomal_RNA -query ${fNamePrefix}_FD_read2.fasta -num_threads 30 -outfmt "6 qseqid qseq" > BLAST_out/${fNamePrefix}_blast_matches.csv 

echo "Retrieving 16S reads from fasta"
sed -i 's/ /_/g' ${fNamePrefix}_FD_read2.fastq
cut -f1 BLAST_out/${fNamePrefix}_blast_matches.csv | grep -A3 -f - ${fNamePrefix}_FD_read2.fastq > 16S_reads/${fNamePrefix}_FD_read_16S.fastq

awk '!/--/' 16S_reads/${fNamePrefix}_FD_read_16S.fastq > 16_S_reads_cleaned/${fNamePrefix}_FD_read_16S_clean.fastq

rm ${fNamePrefix}_FD_read2.fastq
rm ${fNamePrefix}_FD_read2.fasta