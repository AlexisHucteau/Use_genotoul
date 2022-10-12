#!/bin/bash

cd /work/PTBP1_cell_line_fastq

tmp_files=$(ls | grep tmp_output_prep_)

for i in $(seq < wc -l < $tmp_files)
do
  python cp_with_prefix.py prep_$i\_ /work/PTBP1_cell_line_fastq/tmp_output_post/ $tmp_files[$i]/*.rmats
done
