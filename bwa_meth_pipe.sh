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

flexbar -r ${r1} -p ${r2} -aa TruSeq -ap ON -t ${out}"/trim_data/"${name}".fastq"