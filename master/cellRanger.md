






```bash
module load cellranger/5.0.1
module load bcl2fastq/2.20.0

sampleName="test123"
referenceTranscriptomeDir=""
sampleFastqDirectory=""
jobModeType="lsf"
memoryLimitGB="128"
```

```cellranger count --id=$sampleName --transcriptome=$referenceTranscriptomeDir --fastqs=$sampleFastqDirectory --jobmode=$jobModeType --localmem $memoryLimitGB```
