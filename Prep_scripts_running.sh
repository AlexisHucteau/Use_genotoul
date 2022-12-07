#!/bin/bash

read -p 'Workdir:' workdir
cd $workdir

for prep in ./script_pre_*
do
  sbatch $prep
  echo $prep running!
done

echo FINNISHED!
