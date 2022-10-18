#!/bin/bash
#SBATCH -p workq
#SBATCH -t 1-00:00:00 #Acceptable time formats include "minutes", "minutes:seconds", "hours:minutes:seconds", "days-hours", "days-hours:minutes" and "days-hours:minutes:seconds".
#SBATCH --cpus-per-task 7
#SBATCH --mem=100G

#Load modules
#Need Miniconda3
module load system/Miniconda3
module load bioinfo/STAR-2.6.0c

STAR --runThreadN 7 --outSAMtype BAM Unsorted \
  --readFilesIn $1$2$3 $1$2$4 \
  --genomeDir /home/ahucteau/work/star-genome/ \
  --outSAMattributes NH HI AS NM MD XS \
  --twopassMode Basic \
  --alignSJDBoverhangMin 1 \
  --alignSJoverhangMin 8 \
  --alignIntronMax 1000000 \
  --readFilesCommand zcat \
  --outSAMstrandField intronMotif \
  --sjdbGTFfile /home/ahucteau/work/Homo_sapiens.GRCh38.99.gtf \
  --outFileNamePrefix $1$5\/$2 \
  --chimSegmentMin 2 \
  --outFilterMismatchNmax 3
