#!/bin/bash

read -p 'Batch A to compare: ' batchA
read -p 'Batch B to compare: ' batchB
read -p 'Comparison name: ' Comp_name

echo '#!/bin/bash' > $Study_name\_$Comp_name\_post_rmats_script.sh
echo '#SBATCH -p workq' >> $Study_name\_$Comp_name\_post_rmats_script.sh

echo '#SBATCH -t 01:00:00 #Acceptable time formats include "minutes", "minutes:seconds", "hours:minutes:seconds", "days-hours", "days-hours:minutes" and "days-hours:minutes:seconds".' >> $Study_name\_$Comp_name\_post_rmats_script.sh
echo '#SBATCH --cpus-per-task 7' >> $Study_name\_$Comp_name\_post_rmats_script.sh
echo '#SBATCH --mem=100G' >> $Study_name\_$Comp_name\_post_rmats_script.sh

echo '#Load modules' >> $Study_name\_$Comp_name\_post_rmats_script.sh
echo '#Need Miniconda3' >> $Study_name\_$Comp_name\_post_rmats_script.sh
echo 'module load system/Miniconda3' >> $Study_name\_$Comp_name\_post_rmats_script.sh
echo 'module load bioinfo/STAR-2.6.0c' >> $Study_name\_$Comp_name\_post_rmats_script.sh

echo 'module load bioinfo/rmats-turbo-v4.1.2' >> $Study_name\_$Comp_name\_post_rmats_script.sh

echo 'cd $workdir' >> $Study_name\_$Comp_name\_post_rmats_script.sh
echo 'run_rmats --b1 /path/to/post1.txt --b2 /path/to/post2.txt \' >> $Study_name\_$Comp_name\_post_rmats_script.sh
echo '--gtf ~/work/Homo_sapiens.GRCh38.99.gtf -t paired \' >> $Study_name\_$Comp_name\_post_rmats_script.sh
echo '--readLength 151 --nthread 7 --od /path/to/output \' >> $Study_name\_$Comp_name\_post_rmats_script.sh
echo '--tmp /path/to/tmp_output_post --task post' >> $Study_name\_$Comp_name\_post_rmats_script.sh
