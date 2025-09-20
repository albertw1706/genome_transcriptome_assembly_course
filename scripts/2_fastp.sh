#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp
#SBATCH --mail-user=albert.widjaja@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/awidjaja/assembly_course/output_fastp_%j.o
#SBATCH --error=/data/users/awidjaja/assembly_course/error_fastp_%j.e
#SBATCH --partition=pibu_el8

in_dir="/data/users/awidjaja/assembly_course"
out_dir="/data/users/awidjaja/assembly_course/fastp_res"

apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/fastp_0.24.1.sif fastp -i /input/ERR754081_1.fastq.gz -I /input/ERR754081_2.fastq.gz -o /output/clean_ERR754081_1.fastq.gz -O /output/clean_ERR754081_2.fastq.gz --html /output/ERR754081.html --json /output/ERR754081.json -w 8 --trim_poly_x

apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/fastp_0.24.1.sif fastp -i /input/ERR11437321.fastq.gz -o /output/clean_ERR11437321.fastq.gz --html /output/ERR11437321.html --json /output/ERR11437321.json -w 8