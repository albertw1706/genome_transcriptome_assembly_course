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


# set variables
WORKDIR="/data/users/awidjaja/assembly_course"
BUSCO_DIR="${WORKDIR}/busco_res"
OUT_DIR="${WORKDIR}/busco_res/all"

# Load BUSCO module
module load BUSCO/5.4.2-foss-2021a
# create directory if not available
mkdir -p $OUT_DIR

# Find and copy all BUSCO summary files (since we used --auto-lineage, the lineage names will vary)
echo "Looking for BUSCO summary files..."
find $BUSCO_DIR -name "short_summary.*.txt" -exec cp {} $OUT_DIR/ \;

# List what files we found
echo "Summary files found:"
ls -la $OUT_DIR/*.txt

# generate plots using the BUSCO module's generate_plot.py
echo "Generating BUSCO plots..."
cd $OUT_DIR
generate_plot.py -wd $OUT_DIR

  