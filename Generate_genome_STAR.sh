#!/bin/bash
#SBATCH  -p workq
#SBATCH -J STAR
#SBATCH -o STAR.stdout
#SBATCH -e STAR.stderr
#SBATCH -n 12
#SBATCH -t 12:00:00
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4000

#Load binaries
module load bioinfo/STAR-2.5.1b

# calculate indexes. You don't need to recalculate the indexes if they already exist.
mkdir star-genome
STAR --runMode genomeGenerate --genomeDir ~/work/star-genome \
  --genomeFastaFiles ~/work/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
  --runThreadN 12
