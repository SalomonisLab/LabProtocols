#!/bin/bash

BAM=$1
SAMPLE=$(basename $BAM .bam)
DIR=$(pwd)

cat <<EOF
#BSUB -L /bin/bash
#BSUB -W 05:00
#BSUB -n 2
#BSUB -R "span[ptile=2]"
#BSUB -M 8000
#BSUB -e $DIR/logs/%J_index_junction.err
#BSUB -o $DIR/logs/%J_index_junction.out
#BSUB -J $SAMPLE

mkdir -p logs
cd $DIR
module load python/2.7.5
module load samtools


python /data/salomonis2/software/AltAnalyze/import_scripts/BAMtoJunctionBED.py --i $BAM --species Hs --r /data/salomonis2/software/AltAnalyze-91/AltAnalyze/AltDatabase/EnsMart91/ensembl/Hs/Hs_Ensembl_exon.txt

python /data/salomonis2/software/AltAnalyze/import_scripts/BAMtoExonBED.py --i $BAM --r /data/salomonis2/Genomes/exonrefdir_hg38/Hs.bed --s Hs

EOF
#for i in *.bam; do ./index-junction.sh $i | bsub; done
