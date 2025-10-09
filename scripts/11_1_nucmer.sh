#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=nucmer
#SBATCH --mail-user=albert.widjaja@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/awidjaja/assembly_course/output_nucmer_%j.o
#SBATCH --error=/data/users/awidjaja/assembly_course/error_nucmer_%j.e
#SBATCH --partition=pibu_el8

mkdir /data/users/awidjaja/assembly_course/nucmer_res

in_dir="/data/users/awidjaja/assembly_course"
out_dir="/data/users/awidjaja/assembly_course/nucmer_res"

apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/mummer4_gnuplot.sif nucmer -p /output/flye_vs_ref -t 16 --breaklen 1000 --mincluster 1000 /input/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa /input/flye_res/assembly.fasta
apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/mummer4_gnuplot.sif nucmer -p /output/hifiasm_vs_ref -t 16 --breaklen 1000 --mincluster 1000 /input/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa /input/hifiasm_res/ERR11437321_hifiasm.fa
apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/mummer4_gnuplot.sif nucmer -p /output/lja_vs_ref -t 16 --breaklen 1000 --mincluster 1000 /input/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa /input/lja_res/ERR11437321/lja_assembly.fasta

apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/mummer4_gnuplot.sif nucmer -p /output/flye_vs_hifiasm -t 16 --breaklen 1000 --mincluster 1000 /input/flye_res/assembly.fasta /input/hifiasm_res/ERR11437321_hifiasm.fa
apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/mummer4_gnuplot.sif nucmer -p /output/hifiasm_vs_lja -t 16 --breaklen 1000 --mincluster 1000 /input/hifiasm_res/ERR11437321_hifiasm.fa /input/lja_res/ERR11437321/lja_assembly.fasta
apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/mummer4_gnuplot.sif nucmer -p /output/lja_vs_flye -t 16 --breaklen 1000 --mincluster 1000 /input/lja_res/ERR11437321/lja_assembly.fasta /input/flye_res/assembly.fasta

