#!/bin/bash

################### INPUT ###################

# read -p 'Work directory: ' workdir
workdir=$(echo /home/ahucteau/work/TUH_patient_data/output_TUH/)
cd $workdir
# read -p 'List of Fastq: ' Fastq_file
# read -p 'Replicat nomenclature 1 (ex: "_R1_001.fastq.gz"): ' nomenclature_1
# read -p 'Replicat nomenclature 2 (ex: "_R2_001.fastq.gz"): ' nomenclature_2
nomenclature=$(echo Aligned.out.bam)
nFiles=$(ls | wc -l)
nFiles=$(expr $nFiles / 8)
echo There are $nFiles Bams to process.
nprocesses=$(expr $nFiles / 6)
echo It will need $nprocesses process\(es\) to run it fast.

touch BamFiles.txt

for bam in *$nomenclature
do
  echo $workdir$bam >> BamFiles.txt
  echo $workdir$bam
done

################### Sampling ###################

for i in $(seq $nprocesses)
do
  touch prep_auto$i.txt
  start_line=$(expr $i - 1)
  start_line=$(expr $start_line \* 6)
  start_line=$(expr $start_line + 1)
  end_line=$(expr $start_line + 5)
  lines=$(echo $start_line\,$end_line\p)
  sed -n $lines < BamFiles.txt > prep_auto$i.txt
  combined_file=''
  for bamfile in $(cat prep_auto$i.txt)
  do
    combined_file=$combined_file$bamfile,
  done
  echo ${combined_file::-1} > prep_auto$i.txt
  echo ${combined_file::-1}
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
  echo run_rmats --b1 prep_auto$i.txt '\' >> script_pre_$i.sh
  echo   '--gtf ~/work/Homo_sapiens.GRCh38.99.gtf -t paired \' >> script_pre_$i.sh
  echo   '--bi ~/work/star-genome/ \' >> script_pre_$i.sh
  echo   '--readLength 202 --nthread 8 \' >> script_pre_$i.sh
  echo   '--od' output/ '\'>> script_pre_$i.sh
  echo   '--tmp' tmp_output_prep_$i '\' >> script_pre_$i.sh
  echo   '--task prep' >> script_pre_$i.sh
done
