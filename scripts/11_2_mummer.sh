#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=mummer
#SBATCH --mail-user=albert.widjaja@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/awidjaja/assembly_course/output_mummer_%j.o
#SBATCH --error=/data/users/awidjaja/assembly_course/error_mummer_%j.e
#SBATCH --partition=pibu_el8

ref_sample_dir="/data/users/awidjaja/assembly_course"
in_dir="/data/users/awidjaja/assembly_course/nucmer_res"
out_dir="/data/users/awidjaja/assembly_course/mummer_res"


apptainer exec -B "${in_dir}:/input" -B "${out_dir}:/output" -B "/data" /containers/apptainer/mummer4_gnuplot.sif \
  bash -lc 'delta-filter -1 /input/flye.delta > /output/flye.filtered.delta'

apptainer exec -B "${in_dir}:/input" -B "${out_dir}:/output" -B "/data" /containers/apptainer/mummer4_gnuplot.sif \
  bash -lc 'delta-filter -1 /input/hifiasm.delta > /output/hifiasm.filtered.delta'

apptainer exec -B "${in_dir}:/input" -B "${out_dir}:/output" -B "/data" /containers/apptainer/mummer4_gnuplot.sif \
  bash -lc 'delta-filter -1 /input/lja.delta > /output/lja.filtered.delta'


apptainer exec -B "${in_dir}:/input" -B "${out_dir}:/output" -B "${ref_sample_dir}:/sample_ref" -B "/data" /containers/apptainer/mummer4_gnuplot.sif \
  mummerplot -R /sample_ref/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa \
             -Q /sample_ref/flye_res/assembly.fasta \
             --prefix=/output/flye --filter --fat --layout --large -t png /output/flye.filtered.delta

apptainer exec -B "${in_dir}:/input" -B "${out_dir}:/output" -B "${ref_sample_dir}:/sample_ref" -B "/data" /containers/apptainer/mummer4_gnuplot.sif \
  mummerplot -R /sample_ref/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa \
             -Q /sample_ref/hifiasm_res/ERR11437321_hifiasm.fa \
             --prefix=/output/hifiasm --filter --fat --layout --large -t png /output/hifiasm.filtered.delta

apptainer exec -B "${in_dir}:/input" -B "${out_dir}:/output" -B "${ref_sample_dir}:/sample_ref" -B "/data" /containers/apptainer/mummer4_gnuplot.sif \
  mummerplot -R /sample_ref/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa \
             -Q /sample_ref/lja_res/ERR11437321/lja_assembly.fasta \
             --prefix=/output/lja --filter --fat --layout --large -t png /output/lja.filtered.delta




