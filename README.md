# Genome and Transcriptome Assembly

## Repository Overview
This GitHub repository is designated for the project that is a part of the Genome and Transcriptome Assembly course from the University of Bern. The project focuses on running de novo assembly of *Arabidopsis thaliana* genomic (Nov-02) and transcriptomic (Sha) samples, followed by assembly evaluation and comparative genomics.

## Dataset Description
The dataset utilized for this project was obtained from Lian et al. (2024). The SRA accession for the Nov-02 DNA sequencing reads is **ERR11437321**, which originates from the Asia region, and the SRA accession for the Sha RNA-seq reads is **ERR754081**. 

## Repository Structure 
- **scripts**
SLURM scripts to execute analysis (ordered by script number)
- **QC**
Main results of the QC steps (fastQC, fastp, jellyfish)
- **Evaluation and Comparative**
Main results of the assembly evaluation and comparative genomics steps (BUSCO, QUAST, merqury, nucmer/mummer)
