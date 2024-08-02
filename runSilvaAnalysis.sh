# Download and pre-process data
./prepare_data.sh

cd BLAST_analysis
# Prepare directories for output
mkdir vsearch_out
mkdir 16S_reads
mkdir spades_out

# Vsearch to extract cyanobacteria sequences
sbatch --array=1-39 vsearch_16S.sh

# Get the actual reads 
sbatch --array=1-39 get_16S_reads.sh

# SPAdes assembly
sbatch --array=1-39 assemble_16S.sh 