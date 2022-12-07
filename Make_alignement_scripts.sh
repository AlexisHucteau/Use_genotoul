#!/bin/bash

workdir=/home/ahucteau/work/TUH_patient_data/
Fastq_file=List_sample3.txt
nomenclature_1=_R1_001.fastq.gz
nomenclature_2=_R2_001.fastq.gz
output=output_TUH

mkdir $workdir$output

for i in $(cat $workdir$Fastq_file)
do
  echo $i Alignement
  echo $workdir$output\/$i
  sbatch Alignement.sh $workdir $i $nomenclature_1 $nomenclature_2 $output
  sleep 3.5h
done
