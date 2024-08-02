# Get BLAST 16S database
mkdir BLAST_16S_db
wget https://ftp.ncbi.nlm.nih.gov/blast/db/16S_ribosomal_RNA.tar.gz
tar -xvzf 16S_ribosomal_RNA.tar.gz -C  BLAST_16S_db
rm 16S_ribosomal_RNA.tar.gz

# Get CyanoSeq fasta
mkdir CyanoSeq1.1.2
cd CyanoSeq1.1.2
wget https://zenodo.org/records/7569105/files/CyanoSeq_1.1.2.fasta

# Subset the CyanoSeq db for scaffold assembly
cd ../
python subset_CyanoSeq.py

# MAFFT align the subset of CyanoSeq
mafft --adjustdirection --auto CyanoSeq1.1.2/CyanoSeqSubset.fasta > CyanoSeq1.1.2/CyanoSeqSubset_mafft.fasta

# Get SILVA database
mkdir SILVA_db
cd SILVA_db/
wget https://www.arb-silva.de/fileadmin/silva_databases/current/Exports/SILVA_138.1_SSURef_NR99_tax_silva.fasta.gz
gunzip SILVA_138.1_SSURef_NR99_tax_silva.fasta.gz 
cd ../

# Extract Cyanobacteria Sequences from SYLVA
python extract_cyano_seq_SILVA.py