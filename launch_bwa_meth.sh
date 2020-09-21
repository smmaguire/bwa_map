#!/bin/bash

data_path=/mnt/home/smaguire/work/rloops/data/apobec_concentration
mkdir -p /mnt/home/smaguire/work/rloops/apobec_concentration_output
output_path=/mnt/home/smaguire/work/rloops/apobec_concentration_output
mkdir -p $output_path"/qc_pretrim"
mkdir -p $output_path"/qc_posttrim"
mkdir -p $output_path"/trim_data"

for i in $( ls $data_path/*_L001_R1_001.fastq.gz);
do
new_name=${i#$data_path/}
new_name=${new_name%_L001_R1_001.fastq.gz}
echo $new_name 
qsub -v r1=$data_path/$new_name"_L001_R1_001.fastq.gz",r2=$data_path/$new_name"_L001_R2_001.fastq.gz",out=$output_path,name=$new_name bwa_meth_pipe.sh
done
