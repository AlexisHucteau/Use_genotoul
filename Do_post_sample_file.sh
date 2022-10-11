#!/bin/bash

tmp_dir=/home/ahucteau/work/PTBP1_cell_line_fastq/tmp_output_prep_1
Comp_dir=~/GitHub/Use_genotoul

for file in $(cat $Comp_dir/Comp1.txt)
do
  postfile1=$postfile1$tmp_dir/$file/Aligned.sortedByCoord.out.bam,
done

echo ${postfile1::-1} > post1.txt

for file in $(cat $Comp_dir/Comp2.txt)
do
  postfile2=$postfile2$tmp_dir/$file/Aligned.sortedByCoord.out.bam,
done

echo ${postfile2::-1} > post2.txt
