#! /bin/bash

# read -p 'Work directory: ' workdir
# read -p 'List of Fastq: ' Fastq_file
Fastq_file=$(echo List_new.txt)
tmpdir=$(echo ~/GitHub/Use_genotoul)
# read -p 'Bam directory: ' bamdir
bamdir=$(echo ~/GitHub/Use_genotoul/bamdir)

ntmp=$(ls $tmpdir | grep tmp_output_prep_ | wc -l)
nbamPerProcess=$(ls $bamdir | grep 1_ | wc -l)
echo $nbamPerProcess
echo $ntmp

for i in $(seq $ntmp)
do
  nbam=$(ls $bamdir | grep $i\_ | wc -l)
  echo $nbam
  for j in $(seq $nbam)
  do
    echo $i $j
    line=$(expr $i - 1)
    line=$(expr $line \* $nbamPerProcess)
    line=$(expr $line + $j)
    line=$(echo $line\p)
    echo $line
    bamname=$(sed -n $line $Fastq_file)
    echo $bamname
    mv $bamdir/$i\_$j.bam $bamdir/$bamname
  done
done
