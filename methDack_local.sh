#!/bin/bash
source activate methylDackel

for i in $( ls *.bam); do
	MethylDackel extract ptw120.fasta $i
done
