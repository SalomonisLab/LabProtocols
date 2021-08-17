


1. load required R libraries
```{r}
library(SoupX)
library(Matrix)
library(dplyr)
library(DropletUtils)
library(matrixStats)
```


2. Set working directory where would like soupx Output
```{r}
setwd("/data/salomonis2/LabFiles/Katrina/Mo_Kashani_scRNASeq/soupxOut/")
```
3. Load cellranger data into SoupX


```{r}
dataDirs = c("/data/salomonis2/LabFiles/Katrina/Mo_Kashani_scRNASeq/results/2f2-MM565/outs")
sc = load10X(dataDirs, keepDroplets = TRUE)
```

4.a) Set contamination fraction manually

```{r}
sc = setContaminationFraction(sc,as.numeric(0.25), forceAccept = TRUE)
head(sc$soupProfile[order(sc$soupProfile$est, decreasing = TRUE), ], n = 20)
out = adjustCounts(sc,roundToInt=TRUE)
cntSoggy = rowSums(sc$toc > 0)
cntStrained = rowSums(out > 0)
mostZeroed = tail(sort((cntSoggy - cntStrained)/cntSoggy), n = 10)
#mostZeroed
tail(sort(rowSums(sc$toc > out)/rowSums(sc$toc > 0)), n = 20)
#message("writting new mtx files to soupX-contamination-fraction- folder ...")
DropletUtils:::write10xCounts("2f2-MM565_soupx", out)
```

4.b) Estimate contamination fraction

I. set marker gene list
```{r}
markerGenes = "/data/salomonis2/LabFiles/Katrina/Mo_Kashani_scRNASeq/results/4h2-MM617/outs/filtered_feature_bc_matrix/ICGS-NMF_cosine_cc/MarkerGenes.txt"
markers <-read.delim(markerGenes, h=T)
markers <- markers[order(-markers$Pearson.rho),] ## sorting by decreasing order
markers <- markers%>%filter(Pearson.rho >= 0.70)
##markers2 = markers%>%group_by(Cell.State)%>% top_n(n=2, wt = Pearson.rho)
nonExpressedGeneList <- list(ICGS = markers$UID); ICGS <- markers$UID

message("Reading the mtx files from the outs folder ...")
sc = load10X(dataDir = dataDirs, keepDroplets = TRUE)
head(sc$soupProfile[order(sc$soupProfile$est, decreasing = TRUE), ], n = 20)
useToEst = estimateNonExpressingCells(sc, nonExpressedGeneList = list(IG = ICGS), clusters = FALSE, maximumContamination = 0.8, FDR = 0.05)

#####Calculating the contamination fraction#######
message("estimating contamination from the soup channel ...")
fraction <-capture.output(c_fraction = calculateContaminationFraction(sc, list(IG = ICGS), useToEst = useToEst, forceAccept = TRUE), type = "message")
print(fraction)
fraction <- gsub(pattern = c("Estimated global contamination fraction of ", "%"),  replacement = "", x = fraction[1])
print(paste("total percentage of contamination estimeted ", "is", fraction))
fraction$percent <- gsub(pattern = "%", replacement = "", x = fraction)

### ---  Removing Contamination Now --- ###
message("removing the contamination fraction ...")
sc = setContaminationFraction(sc,as.numeric(fraction$percent)/100, forceAccept = TRUE)
head(sc$soupProfile[order(sc$soupProfile$est, decreasing = TRUE), ], n = 20)
out = adjustCounts(sc,roundToInt=TRUE)
cntSoggy = rowSums(sc$toc > 0)
cntStrained = rowSums(out > 0)
mostZeroed = tail(sort((cntSoggy - cntStrained)/cntSoggy), n = 10)
mostZeroed
tail(sort(rowSums(sc$toc > out)/rowSums(sc$toc > 0)), n = 20)
message("writting new mtx files to soupX-contamination-fraction- folder ...")
DropletUtils:::write10xCounts("4h2-MM617_soupx", out)
#DropletUtils:::write10xCounts(paste("./soupX-contamination-fraction_",fraction$percent, sep = ""), out)
```


5. The soupx output file directory will then be supplied as ChromiumSparseMatrix to run altAnalyze
