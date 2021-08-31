

These steps will show you how to run altAnalyze on just one cluster for sub-clustering within cluster of interest

1. Identify the cluster you would like to sub-cluster on based on looking ICGS-NMF*/ directory and MarkerGenes.txt file. In MarkerGenes.txt, identify the cluster that is highly correlated to your marker gene of interest.


2. Cut that cluster from FinalGroups.txt file in the ICGS-NMF* directory of interest in excel or using the awk command listed below
i.e.

```bash

finalGroupFile="/data/salomonis2/LabFiles/Katrina/activeCollabs/Schuh_Rhesus/results/newMergedNo405/ICGS-NMF_cosine_cc/FinalGroups.txt"
outFile="/data/salomonis2/LabFiles/Katrina/activeCollabs/Schuh_Rhesus/results/newMergedNo405/ICGS-NMF_cosine_cc/c29_updatd.txt"
colOfInterst=29

awk '$3 == $colOfInterst { print }' $finalGroupFile > $outFile

```

3. Get location of the exp.sampleName.txt in ExpressionInput directory
```bash

../ExpressionInput/exp.sameName.txt

```

4. Generate filtered exp file via sampleIndexSelection.py script from altAnalyze
```bash
#where merged_kidney = samplename
expFile="/ExpressionInput/exp.merged_kidney.txt"
filtered="/ICGS-NMF_cosine_cc/outFile.txt"

python /AltAnalyze-100/import_scripts/sampleIndexSelection.py --i $expFile --f $filtered

```

5. move new filtered file from ExpressionInput folder to new directory
```bash

mv /ExpressionInput/exp.merged_kidney-filtered.txt $newDirName
```


6. Run altanalyze on new exp filtered file with different variations of clustering

```bash
expFile="/c29_filtered/exp.merged_kidney-filtered.txt"
outputDir="/c29_filtered"
expName="merged_c29"

python /data/salomonis2/software/AltAnalyze-100/AltAnalyze.py --runICGS yes --platform "RNASeq" --species Ma --column_method hopach --column_metric cosine --rho 0.2 --ExpressionCutoff 1 --FoldDiff 4 --SamplesDiffering 4 --restrictBy protein_coding --expdir $expFile --output $outputDir --excludeCellCycle no --removeOutliers yes --expname $expName

mv $outputDir/ICGS-NMF $outputDir/ICGS-NMF_cosine_cc

###NOTE: ICGS-NMF-cosine, ICGS-NMF_euclidean, ICGS-NMF_euclidean-cc are not listed for simplicity in documentation

```
