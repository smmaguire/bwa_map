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

flexbar -r ${r1} -p ${r2} -aa nextara -ap ON -t ${out}"/trim_data/"$new_name.fastq