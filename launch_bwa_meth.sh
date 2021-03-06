#!/bin/bash

data_path=/mnt/home/smaguire/work/rloops/data/whole_genome_method/tagment_plasmid5
output_path=/mnt/home/smaguire/work/rloops/whole_genome_method_output/tagment_plasmid5
reference_path=/mnt/home/smaguire/work/rloops/reference_files/ptw120_new_orient.fasta
mkdir -p $output_path"/qc_pretrim"
mkdir -p $output_path"/qc_posttrim"
mkdir -p $output_path"/trim_data"
mkdir -p $output_path"/mapped_data"

for i in $( ls $data_path/*_L001_R1_001.fastq.gz);
do
new_name=${i#$data_path/}
new_name=${new_name%_L001_R1_001.fastq.gz}
echo $new_name 
qsub -v r1=$data_path/$new_name"_L001_R1_001.fastq.gz",r2=$data_path/$new_name"_L001_R2_001.fastq.gz",out=$output_path,name=$new_name,reference=$reference_path bwa_meth_pipe.sh
done


##for i in $( ls $data_path/ssDNA*_L001_R1_001.fastq.gz);
##do
##new_name=${i#$data_path/}
##new_name=${new_name%_L001_R1_001.fastq.gz}
##echo $new_name 
##qsub -v r1=$data_path/$new_name"_L001_R1_001.fastq.gz",r2=$data_path/$new_name"_L001_R2_001.fastq.gz",out=$output_path,name=$new_name bwa_meth_pipe_ss.sh
##done
