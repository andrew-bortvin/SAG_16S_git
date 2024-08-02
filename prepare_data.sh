# Get BLAST 16S database
mkdir BLAST_16S_db
wget https://ftp.ncbi.nlm.nih.gov/blast/db/16S_ribosomal_RNA.tar.gz
tar -xvzf 16S_ribosomal_RNA.tar.gz -C  BLAST_16S_db
rm 16S_ribosomal_RNA.tar.gz