#!/bin/bash

workdir=/home/ahucteau/work/Koichi_data/
Fastq_file=List_sample2.txt
nomenclature_1=_1.fastq.gz
nomenclature_2=_2.fastq.gz
output=output_Koichi

mkdir $workdir$output

for i in $(cat $workdir$Fastq_file)
do
  echo $i Alignement
  echo $workdir$output\/$i
  sbatch Alignement.sh $workdir $i $nomenclature_1 $nomenclature_2 $output
  sleep 3.5h
done
