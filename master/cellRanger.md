






```bash
sampleName="test123"
referenceTranscriptomeDir=""
sampleFastqDirectory=""
jobModeType="lsf"
memoryLimitGB="128"

cellranger count --id=$sampleName --transcriptome=$referenceTranscriptomeDir --fastqs=$sampleFastqDirectory --jobmode=$jobModeType --localmem $memoryLimitGB
```
