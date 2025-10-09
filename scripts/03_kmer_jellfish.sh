#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=jellyfish
#SBATCH --mail-user=albert.widjaja@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/awidjaja/assembly_course/output_jellyfish_%j.o
#SBATCH --error=/data/users/awidjaja/assembly_course/error_jellyfish_%j.e
#SBATCH --partition=pibu_el8

mkdir /data/users/awidjaja/assembly_course/kmer_calc

in_dir="/data/users/awidjaja/assembly_course/fastp_res"
out_dir="/data/users/awidjaja/assembly_course/kmer_calc"

pigz -dk -p 4 "${in_dir}/clean_ERR11437321.fastq.gz"
pigz -dk -p 4 "${in_dir}/clean_ERR754081_1.fastq.gz"
pigz -dk -p 4 "${in_dir}/clean_ERR754081_2.fastq.gz"

apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/jellyfish:2.2.6--0 jellyfish count -C -m 21 -s 5G -t 4 /input/clean_ERR11437321.fastq -o /output/ERR11437321_reads.jf
apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/jellyfish:2.2.6--0 jellyfish count -C -m 21 -s 5G -t 4 /input/clean_ERR754081_1.fastq /input/clean_ERR754081_2.fastq -o /output/ERR754081_reads.jf

apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/jellyfish:2.2.6--0 jellyfish histo -t 4 /output/ERR11437321_reads.jf > "${out_dir}/ERR11437321_reads.histo"
apptainer exec -B ${in_dir}:/input -B ${out_dir}:/output -B "/data" /containers/apptainer/jellyfish:2.2.6--0 jellyfish histo -t 4 /output/ERR754081_reads.jf > "${out_dir}/ERR754081_reads.histo"

rm "${in_dir}/"*.fastq
