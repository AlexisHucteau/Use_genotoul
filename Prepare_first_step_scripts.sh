#!/bin/bash

################### INPUT ###################

# read -p 'Work directory: ' workdir
workdir=$(echo /home/ahucteau/work/Koichi_data)
cd $workdir
# read -p 'List of Fastq: ' Fastq_file
# read -p 'Replicat nomenclature 1 (ex: "_R1_001.fastq.gz"): ' nomenclature_1
# read -p 'Replicat nomenclature 2 (ex: "_R2_001.fastq.gz"): ' nomenclature_2
Fastq_file=$(echo /home/ahucteau/work/Koichi_data/List_sample.txt)
nomenclature_1=$(echo _1.fastq.gz)
nomenclature_2=$(echo _2.fastq.gz)

nFiles=$(wc -l < $Fastq_file)
nprocesses=$(expr $nFiles \* 2)
echo There are $nprocesses fastq to align.
nprocesses=$(expr $nprocesses / 16)
nprocesses=$(expr $nprocesses + 1)
echo It will need $nprocesses process\(es\) to run it in less than 4 days.

################### Sampling ###################

for i in $(seq $nprocesses)
do
  touch prep_auto$i.txt
  start_line=$(expr $i - 1)
  start_line=$(expr $start_line \* 8)
  start_line=$(expr $start_line + 1)
  end_line=$(expr $start_line + 7)
  lines=$(echo $start_line\,$end_line\p)
  sed -n $lines < $Fastq_file > prep_auto$i.txt
  combined_file=''
  for fastqfile in $(cat prep_auto$i.txt)
  do
    combined_file=$combined_file$fastqfile$nomenclature_1:$fastqfile$nomenclature_2,
  done
  echo ${combined_file::-1} > prep_auto$i.txt

  echo '#!/bin/bash' > script_pre_$i.sh
  echo '#SBATCH -p workq' >> script_pre_$i.sh

  echo '#SBATCH -t 4-00:00:00' >> script_pre_$i.sh
  echo '#SBATCH --cpus-per-task 8' >> script_pre_$i.sh
  echo '#SBATCH --mem-per-cpu=4000' >> script_pre_$i.sh

  echo '#Load modules' >> script_pre_$i.sh
  echo '#Need Miniconda3' >> script_pre_$i.sh
  echo 'module load system/Miniconda3' >> script_pre_$i.sh
  echo 'module load bioinfo/STAR-2.6.0c' >> script_pre_$i.sh

  echo 'module load bioinfo/rmats-turbo-v4.1.2' >> script_pre_$i.sh
  echo cd $workdir >> script_pre_$i.sh
  echo run_rmats --s1 prep_auto$i.txt '\' >> script_pre_$i.sh
  echo   '--gtf ~/work/Homo_sapiens.GRCh38.99.gtf -t paired \' >> script_pre_$i.sh
  echo   '--bi ~/work/star-genome/ \' >> script_pre_$i.sh
  echo   '--outBAMsortingBinsN 100 \' >> script_pre_$i.sh
  echo   '--readLength 151 --nthread 8 \' >> script_pre_$i.sh
  echo   '--od' output/ '\'>> script_pre_$i.sh
  echo   '--tmp' tmp_output_prep_$i '\' >> script_pre_$i.sh
  echo   '--task prep' >> script_pre_$i.sh
done
