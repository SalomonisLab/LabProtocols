#!/bin/bash

BAM=$1
SAMPLE=$(basename $BAM .bam)
DIR=$(pwd)

cat <<EOF
#BSUB -L /bin/bash
#BSUB -W 06:00
#BSUB -n 6
#BSUB -R "span[ptile=4]"
#BSUB -M 32000
#BSUB -e $DIR/error.err
#BSUB -o $DIR/error.out
#BSUB -J $SAMPLE

module load python/2.7.5
cd $DIR

python /data/salomonis2/LabFiles/Audrey/TestCode/Classification_SVM.py --Training $DIR/Hs_RNASeq_top_alt_junctions-PSI_EventAnnotation-75p.txt --group $DIR/MergedResult.txt --diffevents /data/salomonis2/NCI-R01/TCGA_AML/DE_splicing_events/Events-dPSI_0.1_adjp --Test $DIR/Hs_RNASeq_top_alt_junctions-PSI_EventAnnotation-filtered-names-75p.txt --normalize True --Multigroup True --adjp True --o-v-o yes


EOF
#./SupervisedAnalysis.sh | bsub
#Example input and output results: /Volumes/salomonis2/NCI-R01/TCGA_AML/Supervised_Analysis
