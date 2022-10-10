#!/bin/bash
#SBATCH -p workq
#SBATCH -t 1-00:00:00 #Acceptable time formats include "minutes", "minutes:seconds", "hours:minutes:seconds", "days-hours", "days-hours:minutes" and "days-hours:minutes:seconds".
#SBATCH --cpus-per-task 7
#SBATCH --mem=100G

#Load modules
#Need Miniconda3
module load system/Miniconda3
module load bioinfo/STAR-2.6.0c

module load bioinfo/rmats-turbo-v4.1.2

cd ~/work/PTBP1_cell_line_fastq/

run_rmats --s1 ~/work/prep1.txt \
  --gtf ~/work/Homo_sapiens.GRCh38.99.gtf -t paired \
  --bi ~/work/star-genome/ \
  --readLength 150 --nthread 7 \
  --od ~/work/PTBP1_cell_line_fastq/output/ --tmp ~/work/PTBP1_cell_line_fastq/tmp_output_prep_1 \
  --task prep
