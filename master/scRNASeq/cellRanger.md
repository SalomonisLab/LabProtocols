




Load required modules 

```bash
module load cellranger/5.0.1
module load bcl2fastq/2.20.0
```
Assign parameters for cellranger command 

```sampleName="test123"
referenceTranscriptomeDir=""
sampleFastqDirectory=""
jobModeType="lsf"
memoryLimitGB="128"
```

Run cellranger command with user supplied parameters

```cellranger count --id=$sampleName --transcriptome=$referenceTranscriptomeDir --fastqs=$sampleFastqDirectory --jobmode=$jobModeType --localmem $memoryLimitGB```
