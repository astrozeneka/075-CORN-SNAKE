#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 96:00:00
#SBATCH -J bam_split
#SBATCH -A proj5057

module purge
module load GATK/4.2.0.0-GCCcore-10.2.0-Java-1.8.0_292-OpenJDK

REFERENCE="data/reference/GCF_001185365.1_UNIGE_PanGut_3.0_genomic.fna"
gatk PreprocessIntervals \
  -R "${REFERENCE}" \
  --padding 0 \
  -imr OVERLAPPING_ONLY \
  -O data/reference/interval_list.list