#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=LJA
#SBATCH --mail-user=albert.widjaja@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/awidjaja/assembly_course/output_LJA_%j.o
#SBATCH --error=/data/users/awidjaja/assembly_course/error_LJA_%j.e
#SBATCH --partition=pibu_el8

in_dir="/data/users/awidjaja/assembly_course/fastp_res"
out_dir="/data/users/awidjaja/assembly_course/lja_res"

apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/lja-0.2.sif lja -o /output/ERR11437321 --reads /input/clean_ERR11437321.fastq.gz -t 16