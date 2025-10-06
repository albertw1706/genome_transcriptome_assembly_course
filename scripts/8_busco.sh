#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=busco
#SBATCH --mail-user=albert.widjaja@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/awidjaja/assembly_course/output_busco_%j.o
#SBATCH --error=/data/users/awidjaja/assembly_course/error_busco_%j.e
#SBATCH --partition=pibu_el8

in_flye_dir="/data/users/awidjaja/assembly_course/flye_res"
in_hifiasm_dir="/data/users/awidjaja/assembly_course/hifiasm_res"
in_lja_dir="/data/users/awidjaja/assembly_course/lja_res/ERR11437321"
in_trinity_dir="/data/users/awidjaja/assembly_course/trinity_res"
out_dir="/data/users/awidjaja/assembly_course/busco_res"

module load BUSCO/5.4.2-foss-2021a

busco -i /${in_flye_dir}/assembly.fasta --mode genome -l brassicales_odb10 --cpu 16 -o flye --out_path ${out_dir}

busco -i /${in_hifiasm_dir}/ERR11437321_hifiasm.fa --mode genome -l brassicales_odb10 --cpu 16 -o hifiasm --out_path ${out_dir}

busco -i /${in_lja_dir}/lja_assembly.fasta --mode genome -l brassicales_odb10 --cpu 16 -o lja --out_path ${out_dir}

busco -i /${in_trinity_dir}/trinity_res.Trinity.fasta --mode transcriptome -l brassicales_odb10 --cpu 16 -o trinity --out_path ${out_dir}

