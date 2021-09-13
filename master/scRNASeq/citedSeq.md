
1. the name of GEX and ADTS have to match before the _S2_R1_001.fastq.gz information. The sample column in libraries file provided to parameter --id provided to cell ranger count command

sample name provided to --id and in sample column in library file must match and be the first characters before the last _S_R1* value



2. Generate library file (library.csv) with following format:


| fastqs | sample | library_type |
| ------------- | ------------- |
| Directory for fastqs  | sampleName  | Gene Expression |
| Directory for fastqs  | sampleName  | Antibody Capture |

**Note this sample value in library.csv must match the value provided to the --id in cellranger count function


example library:

/data/salomonis2/Grimes/RNA/scRNA-Seq/10x-Genomics/X202SC21012876-Z01-F001/ADT_cellranger/Human/Merged_Human/ND162TNC_ND20-162-TNC


3. determine barcode for feature ref file based on Antibody capture used as referenced here:

https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/feature-bc-analysis#feature-ref
 TotalSeq™-A was last one used with Haringer-Singh data


4. reference must be generated from cellranger arc Please make sure that you have downloaded the correct 10x reference or generated a custom reference using `mkref`. Cell Ranger ATAC pipelines are compatible with Cell Ranger ATAC 2.0 or Cell Ranger ARC 1.0+ references. Cell Ranger ARC pipelines are compatible with a Cell Ranger ARC 1.0+ reference

/data/salomonis2/LabFiles/Daud/Genomes/multi_ome/hg38
