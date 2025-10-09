#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=trinity
#SBATCH --mail-user=albert.widjaja@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/awidjaja/assembly_course/output_trinity_%j.o
#SBATCH --error=/data/users/awidjaja/assembly_course/error_trinity_%j.e
#SBATCH --partition=pibu_el8

in_dir="/data/users/awidjaja/assembly_course/fastp_res"
out_dir="/data/users/awidjaja/assembly_course"

cd ${out_dir}

module load Trinity/2.15.1-foss-2021a

Trinity --seqType fq --left ${in_dir}/clean_ERR754081_1.fastq.gz --right ${in_dir}/clean_ERR754081_2.fastq.gz --CPU 16 --max_memory 64G --output trinity_res
