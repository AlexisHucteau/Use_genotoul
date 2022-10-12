#!/bin/bash

Study_name=echo PTBP1
workdir=echo /work/PTBP1_cell_line_fastq

Batch_files=$(ls | grep batch)
Comparison_file=$(cat $workdir/Comparison_file.txt)

for batch in $Batch_files
do
  echo $batch
  for bam_file in $(cat $batch)
  do
    combined_batch=$combined_batch,$bamfile
  done
  echo ${combined_batch::-1} > $batch\_comp_file.txt
done
