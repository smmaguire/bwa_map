#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#$ -pe smp 1
#$ -m e

source activate bwa_meth
### fastqc1
fastqc ${r1} --outdir=${out}"/qc_pretrim/"
fastqc ${r2} --outdir=${out}"/qc_pretrim/"

### Trim reads
### Trim off the nicking site of read2. Then trim the adapters.
adap_path=/mnt/home/smaguire/work/rloops/adapter_files/adapter1.fasta 
flexbar -r ${r2} --pre-trim-left 5 -t ${out}"/trim_data_temp/"${name}"r2_trim"
flexbar -r ${r1} -p ${out}"/trim_data_temp/"${name}"r2_trim.fastq" -a $adap_path -ap ON -q TAIL -qf i1.8 -qt 25 -t ${out}"/trim_data/"${name}

### fastqc2
fastqc ${out}"/trim_data/"${name}_1.fastq --outdir=${out}"/qc_posttrim/"
fastqc ${out}"/trim_data/"${name}_2.fastq --outdir=${out}"/qc_posttrim/"
