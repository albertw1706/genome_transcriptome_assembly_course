#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=flye
#SBATCH --mail-user=albert.widjaja@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/awidjaja/assembly_course/output_flye_%j.o
#SBATCH --error=/data/users/awidjaja/assembly_course/error_flye_%j.e
#SBATCH --partition=pibu_el8

mkdir /data/users/awidjaja/assembly_course/flye_res

in_dir="/data/users/awidjaja/assembly_course/fastp_res"
out_dir="/data/users/awidjaja/assembly_course/flye_res"

apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/flye_2.9.5.sif flye --pacbio-hifi /input/clean_ERR11437321.fastq.gz --out-dir /output --threads 16 
