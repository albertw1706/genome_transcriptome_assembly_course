#!/bin/bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --mail-user=albert.widjaja@students.unibe.ch
#SBATCH --partition=pibu_el8
#SBATCH --job-name=Busco_plots
#SBATCH --output=/data/users/awidjaja/assembly_course/output_nucmer_%j.o
#SBATCH --error=/data/users/awidjaja/assembly_course/error_nucmer_%j.e
#SBATCH --mail-type=error,end

WORKDIR="/data/users/awidjaja/assembly_course"
BUSCO_DIR="${WORKDIR}/busco_res"
OUT_DIR="${WORKDIR}/busco_res/all"

module load BUSCO/5.4.2-foss-2021a

mkdir -p $OUT_DIR

find $BUSCO_DIR -name "short_summary.*.txt" -exec cp {} $OUT_DIR/ \;

ls -la $OUT_DIR/*.txt

# generate plots using the BUSCO module's generate_plot.py
cd $OUT_DIR
generate_plot.py -wd $OUT_DIR

  
