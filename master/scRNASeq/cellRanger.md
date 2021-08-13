1. Assign lsbatch environment variables
```bash
#BSUB -L /bin/bash
#BSUB -W 50:00
#BSUB -n 4
#BSUB -M 128000
#BSUB -e /data/salomonis2/LabFiles/Katrina/Mo_Kashani_scRNASeq/results/2f2-MM565/logs/%J.err
#BSUB -o /data/salomonis2/LabFiles/Katrina/Mo_Kashani_scRNASeq/results/2f2-MM565/logs/%J.out
#BSUB -J 2f2-MM565
```

| Options | Description | default/recommended |
| :---         |     :---:      |          ---: |
| -L  | login shell     | /bin/bash    |
| -W     | run time limit (hours:minutes)      | 50:00     |
| -n     | number of processes required for parallel job      | 4    |
| -M     | memory limit (MB)      | 128000    |
| -e     | error file      | Name of error file    |
| -o     | output file      | Name of output file    |
| -J     | job name     | Name of job    |


2. Load required modules 

```bash
module load cellranger/5.0.1
module load bcl2fastq/2.20.0
```
3. Assign parameters for cellranger command 

```sampleName="test123"
referenceTranscriptomeDir=""
sampleFastqDirectory=""
jobModeType="lsf"
memoryLimitGB="128"
```

4. Run cellranger command with user supplied parameters

```cellranger count --id=$sampleName --transcriptome=$referenceTranscriptomeDir --fastqs=$sampleFastqDirectory --jobmode=$jobModeType --localmem $memoryLimitGB```
