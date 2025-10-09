#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=albert.widjaja@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/awidjaja/assembly_course/output_fastqc_%j.o
#SBATCH --error=/data/users/awidjaja/assembly_course/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

cd /data/users/awidjaja/assembly_course
ln -s /data/courses/assembly-annotation-course/raw_data/Nov-02 ./
ln -s /data/courses/assembly-annotation-course/raw_data/RNAseq_Sha ./

in_dir="/data/users/awidjaja/assembly_course"
out_dir="/data/users/awidjaja/assembly_course/QC"

apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/fastqc-0.12.1.sif fastqc -t 1 -o /output /input/ERR754081_1.fastq.gz /input/ERR754081_2.fastq.gz /input/ERR11437321.fastq.gz

