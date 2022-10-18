#!/bin/bash
#SBATCH -p workq

#SBATCH -t 4-00:00:00
#SBATCH --cpus-per-task 8
#SBATCH --mem-per-cpu=4000
#Load modules
#Need Miniconda3
module load system/Miniconda3
module load bioinfo/STAR-2.6.0c

module load bioinfo/rmats-turbo-v4.1.2

run_rmats --b1 bam.txt \
--gtf ~/work/Homo_sapiens.GRCh38.99.gtf -t paired \
--bi ~/work/star-genome/ \
--readLength 100 --nthread 8 \
--od output_test_koichi/ \
--tmp tmp_output_test_koichi/ \
--task prep
