#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#$ -pe smp 1
#$ -m e

source activate bwa_meth
### fastqc1
###fastqc ${r1} --outdir=${out}"/qc_pretrim/"
###fastqc ${r2} --outdir=${out}"/qc_pretrim/"

### Trim reads
### flexbar -r ${r1} -p ${r2} --adapter-preset TruSeq -ap ON -q TAIL -qf i1.8 -qt 25 -t ${out}"/trim_data/"${name}

### fastqc2
### fastqc ${out}"/trim_data/"${name}_1.fastq --outdir=${out}"/qc_posttrim/"
### fastqc ${out}"/trim_data/"${name}_2.fastq --outdir=${out}"/qc_posttrim/"

#### map with bwa_meth
bwameth.py --reference /mnt/home/smaguire/work/rloops/reference_files/m13_ref.fasta ${out}"/trim_data/"${name}_1.fastq ${out}"/trim_data/"${name}_2.fastq > ${out}"/mapped_data/"${name}".sam"

