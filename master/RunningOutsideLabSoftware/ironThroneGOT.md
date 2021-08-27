

For running Iron-GOT for amplicon genotyping (https://github.com/landau-lab/IronThrone-GoT),
Here are steps to run/modify existing scripts:


1. Create new directory

```bash
mkdir newDirName
```



2. Store the following in your new directory:

  a. barcodes10x directory with barcodes file in directory (https://github.com/landau-lab/IronThrone-GoT/tree/master/barcodes10X
    )

    ```bash
        mkdir barcodes10x
        mv barcodesFile.txt barcodes10x
```


  b. updated config file:

      8 lines for circular RNASeq (circ.config)
      4 lines for linear RNASeq (linear.config)

  c. Both read files unzipped (r1.fq and r2.fq)

  d. IronThrone-GoT perl script located at: https://github.com/landau-lab/IronThrone-GoT/blob/master/IronThrone-GoT

  e. run_GOT.sh : custom bash script to run IronThrone on cluster with example below:

```bash
    #BSUB -L /bin/bash
    #BSUB -W 60:00
    #BSUB -n 8
    #BSUB -M 64000
    #BSUB -e linear_got_R2SRSF2lin34_HJMGVDSX2.err
    #BSUB -o linear_got_R2SRSF2lin34_HJMGVDSX2.out


    module load R/4.0.0
    module load parallel

    outputDir = "sampeName_output"
    #name of output directory to use; seems to be ignored

    sampleName = "sampleName"
    #name of sample to use in script; used in Combine_IronThrone_Parallel_Output.R to rename name of summTable.txt #from  myGoT.summTable.txt to sampleName.summTable.txt

    whiteListFile = "barcodes.txt"
    #whitelist file provided by 10X https://drive.google.com/open?id=1-kMeT_asRhYu9dlCq6CkN49wDMrgcLXn depending on 10x chemistry or a custom .txt file of barcodes from a corresponding 10X run

    10xChemistry = 12
    #10x chemistry version where 10 = 10x v2.chemistry (default) and 12 = 10X v3.chemistry

    numThreads = 16
    #-t  equals number of threads to run on (should not run more than 2x number of cores)

    verboseMode=1
    #-v verbose mode when v = 1; default v = 0


    bash IronThroneParGNULinux.sh  --run circ --config circular_SRSF2.config --fastqR1 SRSF2cir34_R1.fq --fastqR2 SRSF2cir34_R2.fq --sample $sampleName --outdir $outputDir --umilen $10xChemistry -t $numThreads -v $verboseMode --whitelist $whiteListFile
```

    f. Modified UMI script based on OS from: https://github.com/landau-lab/IronThrone-GoT/tree/master/Parallelized_UMI_Collapse
      For running on cluster, we used Linux script https://github.com/landau-lab/IronThrone-GoT/blob/master/Parallelized_UMI_Collapse/IronThroneParGNULinux.sh

      where above this line of code:
      ```bash
      Rscript Combine_IronThrone_Parallel_Output.R $main_output_folder ${pcr_read_threshold} ${levenshtein_distance} ${dupcut}
      ```


      we add the following line of code:


      ```bash
      main_output_folder="newDirName/Output"
      #where newDirName is where all scripts/data are stored for this #IronThrone GOT run; directory created from step 1

      Rscript Combine_IronThrone_Parallel_Output.R $main_output_folder ${pcr_read_threshold} ${levenshtein_distance} ${dupcut}
      ```


    g. Modified Combine_IronThrone_Parallel_Output.R where the following code is changed from:


      ```R
      split_got <- data.frame()
      for (i in list.files()){
        split_got <- rbind(split_got, read.delim(paste0(i,"/myGoT.summTable.txt"), stringsAsFactors = FALSE))
      }
      ```

updated code:


```R
outputDir="newDirName"
#outputDir is the full directory to newDirName with Output added to end of file path name
#i.e. newDirName/Output

sumTableName="sampleNameUsed.summTable.txt"
#sumTableName is sampleName.summTable.txt where .summTable.txt is added to end of sampleName used in parameter --#sample from bash script Run_GOT.sh

split_got <- data.frame()
for (i in list.files(full.names = TRUE, path=outputDir)){
    split_got <- rbind(split_got, read.delim(paste0(i, sumTableName), stringsAsFactors = FALSE))
}
```


3. Submit job via bsub < run_GOT.sh

4. Once completed, you should have two summary files:
myGoT.summTable.concat.txt
myGoT.summTable.concat.umi_collapsed.txt

On salomonis2 drive, you can look under LabFiles --> Katrina --> software --> IronThroneThree for example of how the folder directory should look and examples of each file/modified script
