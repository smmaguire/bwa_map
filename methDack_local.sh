#!/bin/bash
###source activate methylDackel

for i in $( ls *.bam); do
	MethylDackel extract m13_ref.fasta $i
done