#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=hifiasm
#SBATCH --mail-user=albert.widjaja@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/awidjaja/assembly_course/output_hifiasm_%j.o
#SBATCH --error=/data/users/awidjaja/assembly_course/error_hifiasm_%j.e
#SBATCH --partition=pibu_el8

mkdir /data/users/awidjaja/assembly_course/hifiasm_res

in_dir="/data/users/awidjaja/assembly_course/fastp_res"
out_dir="/data/users/awidjaja/assembly_course/hifiasm_res"

apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/hifiasm_0.25.0.sif hifiasm -o /output/ERR11437321 -t 16 -l0 /input/clean_ERR11437321.fastq.gz

