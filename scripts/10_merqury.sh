#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --partition=pibu_el8
#SBATCH --job-name=merqury
#SBATCH --mail-user=albert.widjaja@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/awidjaja/assembly_course/merqury_output_%j.o
#SBATCH --error=/data/users/awidjaja/assembly_course/merqury_error_%j.o

ASSEMBLY_DIR="/data/users/awidjaja/assembly_course"
OUT_DIR="/data/users/awidjaja/assembly_course/merqury_res"
MERQURY_IMG="/containers/apptainer/merqury_1.3.sif"

READS="/data/users/awidjaja/assembly_course/ERR11437321.fastq.gz"

FLYE_FA="$ASSEMBLY_DIR/flye_res/assembly.fasta"
HIFIASM_FA="$ASSEMBLY_DIR/hifiasm_res/ERR11437321_hifiasm.fa"
LJA_FA="$ASSEMBLY_DIR/lja_res/ERR11437321/lja_assembly.fasta"

OUT_DIR="/data/users/awidjaja/assembly_course/merqury_res"

mkdir -p $OUT_DIR

apptainer exec --bind /data --bind /usr/bin/ln:/bin/ln $MERQURY_IMG bash -lc '
    export MERQURY="/usr/local/share/merqury"

    OUT_DIR="'"$OUT_DIR"'"
    READS="'"$READS"'"
    SLURM_CPUS_PER_TASK="'"$SLURM_CPUS_PER_TASK"'"

    FLYE_FA="'"$FLYE_FA"'"
    HIFIASM_FA="'"$HIFIASM_FA"'"
    LJA_FA="'"$LJA_FA"'"

    K="$("${MERQURY}/best_k.sh" 135000000 | tail -n1 | awk '\''{print int($1+0.5)}'\'')"
    echo "Using k=$K" | tee "$OUT_DIR/k.txt"

    READ_DB="${OUT_DIR}/reads.k$K.meryl"
    if [ ! -d $READ_DB ]; then
        meryl count k=$K threads=$SLURM_CPUS_PER_TASK output $READ_DB $READS
    fi

    run_merqury () {
        mkdir -p $OUT_DIR/$2_k$K
        cd $OUT_DIR/$2_k$K
        echo $2

        $MERQURY/merqury.sh $READ_DB $1 $2
    }

    run_merqury $FLYE_FA 'flye'
    run_merqury $HIFIASM_FA 'hifiasm'
    run_merqury $LJA_FA 'lja'
'