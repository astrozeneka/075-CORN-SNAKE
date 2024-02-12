#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 32
#SBATCH -t 5-00:00:00
#SBATCH --mem=400G
#SBATCH -J gstacks
#SBATCH -A proj5034

module load foss/2021b
export PATH=$PATH:/tarafs/data/project/proj5034-AGBKU/local/bin/

mkdir -p data/onref_populations
populations -P data/onref_stacks \
  -O data/onref_populations \
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
  -t 32
echo "Populations done"