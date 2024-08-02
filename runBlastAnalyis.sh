# Download and pre-process data
./prepare_data.sh

cd BLAST_analysis
# Prepare directories for output
mkdir 16S_reads
mkdir 16_S_reads_cleaned
mkdir iqtreeOut
mkdir spades_out
mkdir scaffold_assembly

# BLAST Cyano reads against 
sbatch --array=1-39 blast_16s_reads.sh

# SPAdes assembly
sbatch --array=1-39 assemble_16S.sh 

# Align scaffolds to ground truth 16S sequences 
for i in `ls spades_out`
do 
  mkdir scaffold_assembly/${i}
  mafft --adjustdirection --add spades_out/${i}/scaffolds.fasta --keeplength ../CyanoSeq1.1.2/CyanoSeqSubset_mafft.fasta > scaffold_assembly/${i}/CyanoSeqSubset_and_${i}.fasta
done

# Assemble scaffolds
# assembly_sysArgs.txt is manually curated
# .aln files are manually made as well by 
while IFS= read -r line
do
  name=`echo ${line} | cut -f1 -d" "`
  toAssemble=`echo ${line} | cut -f2 -d" "`
  informative=`echo ${line} | cut -f3 -d" "`

  python assemble_mafft_out.py $name $toAssemble $informative

done < assembly_sysArgs.txt

# Prepare input for mafft
cat scaffold_assembly/*/*_aligned.fasta > mafft_in.fasta

# Add outgroups
cat outgroups.fasta mafft_in.fasta > mafft_in_with_outgroups.fasta

# multiple alignment
mafft --adjustdirection --auto mafft_in_with_outgroups.fasta > mafft_out.fasta

# Construct a tree
../iqtree -nt 8 -m MFP -bb 10000 -s mafft_out.fasta -pre iqtreeOut/SAG_BLAST
