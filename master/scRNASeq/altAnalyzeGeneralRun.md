


```bash

module load R/3.5.0
module load python/2.7.5


```




Determining if cell annotations are correct

One way to determine if the cell annotations are correct for UMAP clusters is
to identify known marker genes


1. Copy FinalGroups.txt to exp.captures.txt and repalce everyhting to left of . so remove barcode



python AltAnalyze.py --image "UMAP" --plotType 2D --species Mm --platform RNASeq --labels no --input /Volumes/salomonis2/LabFiles/Katrina/Schuh_Rhesus/Merged_updated/output/ICGS-NMF_cosine_cc/exp.captures.txt --coordinateFile /Volumes/salomonis2/LabFiles/Katrina/Schuh_Rhesus/Merged_updated/output/ICGS-NMF_cosine_cc/FinalMarkerHeatmap_all-UMAP_coordinates.txt


python AltAnalyze.py  --image hierarchical --platform RNASeq --species Hs --display False --input /Volumes/salomonis2/LabFiles/Katrina/Schuh_Rhesus/Merged_updated/output/ICGS-NMF_cosine_cc/FinalMarkerHeatmap_all.txt  --contrast 5 --color_gradient yellow_black_blue --column_method None --row_method None  --normalization median --clusterGOElite BioMarkers

python AltAnalyze.py --accessoryAnalysis annotateICGS --elite_dir /Volumes/salomonis2/LabFiles/Katrina/Schuh_Rhesus/Merged_updated/output/ICGS-NMF_cosine_cc/GO-Elite/clustering/FinalMarkerHeatmap_all/GO-Elite_results/pruned-results_z-score_elite.txt --groupdir /Volumes/salomonis2/LabFiles/Katrina/Schuh_Rhesus/Merged_updated/output/ICGS-NMF_cosine_cc/FinalGroups.txt
