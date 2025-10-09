#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=quast
#SBATCH --mail-user=albert.widjaja@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/awidjaja/assembly_course/output_quast_%j.o
#SBATCH --error=/data/users/awidjaja/assembly_course/error_quast_%j.e
#SBATCH --partition=pibu_el8

mkdir /data/users/awidjaja/assembly_course/quast_res/no_ref
mkdir /data/users/awidjaja/assembly_course/quast_res/ref

in_dir="/data/users/awidjaja/assembly_course"
out_noref_dir="/data/users/awidjaja/assembly_course/quast_res/no_ref"
out_ref_dir="/data/users/awidjaja/assembly_course/quast_res/ref"

apptainer exec -B ${in_dir}:/input -B ${out_noref_dir}:/output -B "/data" /containers/apptainer/quast_5.2.0.sif quast.py /input/flye_res/assembly.fasta /input/hifiasm_res/ERR11437321_hifiasm.fa /input/lja_res/ERR11437321/lja_assembly.fasta --labels "flye,hifiasm,lja" --est-ref-size 135000000 --eukaryote --pacbio /input/fastp_res/clean_ERR11437321.fastq.gz --threads 16 --output-dir /output

apptainer exec -B ${in_dir}:/input -B ${out_ref_dir}:/output -B "/data" /containers/apptainer/quast_5.2.0.sif quast.py /input/flye_res/assembly.fasta /input/hifiasm_res/ERR11437321_hifiasm.fa /input/lja_res/ERR11437321/lja_assembly.fasta --labels "flye,hifiasm,lja" -r /input/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa --features /input/references/Arabidopsis_thaliana.TAIR10.57.gff3 --eukaryote --threads 16 --output-dir /output

