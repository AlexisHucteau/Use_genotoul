#!/bin/bash

read -p 'Work directory: ' workdir
read -p 'Bam directory: ' bamdir
read -p 'rmats directory: ' rmatsdir

cd $workdir
mkdir $bamdir
mkdir $rmatsdir
i=1

for tmp in tmp_output_prep_*
do
  j=1
  cd $tmp
  echo python cp_with_prefix.py prep_$i\_ $rmatsdir/ *.rmats
  # python cp_with_prefix.py prep_$i\_ $rmatsdir/ $tmp*.rmats
  for bam in *_bam*
  do
    bamname=$(echo $i\_$j.bam)
    echo $bamname
    mv $bam ../$bamdir/$bamname
    j=$(expr $j + 1)
  done
  i=$(expr $i + 1)
  cd ..
done

















# tmp_dir=/home/ahucteau/work/PTBP1_cell_line_fastq/tmp_output_prep_1
# Comp_dir=~/GitHub/Use_genotoul
#
# for file in $(cat $Comp_dir/Comp1.txt)
# do
#   postfile1=$postfile1$tmp_dir/$file/Aligned.sortedByCoord.out.bam,
# done
#
# echo ${postfile1::-1} > post1.txt
#
# for file in $(cat $Comp_dir/Comp2.txt)
# do
#   postfile2=$postfile2$tmp_dir/$file/Aligned.sortedByCoord.out.bam,
# done
#
# echo ${postfile2::-1} > post2.txt
