#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 120
#SBATCH -t 24:00:00
#SBATCH -J population
#SBATCH -A proj5034

module load foss/2021b
export PATH=$PATH:/tarafs/data/project/proj5034-AGBKU/local/bin/

mkdir -p populations
populations -P data/gstacks \
  -O data/populations \
  -M popmap.txt \
  --min-samples-per-pop 0.60 \
  --min-maf 0.05 \
  --max-obs-het 0.8 \
  --fstats \
  --fst-correction \
  --genepop \
  --vcf \
  --plink \
  --structure \
  --gtf \
  --fasta-loci \
  --fasta-samples \
  -t 120
echo "Populations done"
