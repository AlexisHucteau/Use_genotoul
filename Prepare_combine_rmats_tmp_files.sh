#!/bin/bash

read -p 'Work directory: ' workdir
read -p 'rmats directory: ' rmatsdir
cd $workdir

tmp_folder=$(ls -d */ | grep tmp_output_prep_)

counter=1

for i in $tmp_folder
do
  python cp_with_prefix.py prep_$counter\_ /work/PTBP1_cell_line_fastq/tmp_output_post/ $i*.rmats
  counter=$(expr $counter + 1)
done


i=1

for tmp in tmp_output_prep_*
do
  cd $tmp
  python cp_with_prefix.py prep_$i\_ $rmatsdir/ $tmp*.rmats
  i=$(expr $i + 1)
  cd ..
done
