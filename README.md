# Cyanobacteria SAG Analysis

Repository hosts all scripts and inputs necessary to reproduce 16S analysis for Cyanobacteria SAGs. 

Important scripts:

* `prepare_data.sh` - downloads the BLAST, SILVA, and CyanoSeq databases and manipulates them as necessary for analysis. Also creates directory structure necessary for intermediate files. 
* `runBlastAnalyis.sh` - all code necessary to extract 16S reads using `blastn` and the BLAST 16S database, and subsequently to construct the phylogeny. 

`BLAST_analysis` directory contains all scripts used by `runBlastAnalyis.sh`. Contains output trees, with all branches <95 bootstrap deleted, as svg image and Newick format.  