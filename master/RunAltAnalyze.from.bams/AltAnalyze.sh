#!/bin/bash

BAM=$1
SAMPLE=$(basename $BAM .bam)
DIR=$(pwd)

cat <<EOF
#BSUB -L /bin/bash
#BSUB -W 03:00
#BSUB -n 4
#BSUB -R "span[ptile=4]"
#BSUB -M 128000
#BSUB -e $DIR/logs/%J.err
#BSUB -o $DIR/logs/%J.out
#BSUB -J $SAMPLE

cd $DIR
mkdir -p logs

module load samtools 
module load python/2.7.5
module load R
module load Bioconductor/3.4-R_3.3.1


python /data/salomonis2/software/AltAnalyze/AltAnalyze.py --species Hs --platform RNASeq --bedDir $DIR --groupdir $DIR/ExpressionInput/groups.SARS.txt --compdir $DIR/ExpressionInput/comps.SARS.txt  --expname SARS --runGOElite no

EOF
#./AltAnalyze.sh | bsub
