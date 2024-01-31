#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 96:00:00
#SBATCH -J bam_split
#SBATCH -A proj5057

module purge
module load GATK/4.2.0.0-GCCcore-10.2.0-Java-1.8.0_292-OpenJDK

# The sample name is from the argument
genome=$1
if [ -z "${genome}" ]; then
  echo "Usage: $0 <genome>" # Example of genome name: AMEL_106
  exit 1
fi

RAW_DATA_DIR="/tarafs/data/home/hrasoara/Projects/075-CORN-SNAKE/data/X401SC21090035-Z01-F001_01/02.Bam"
REFERENCE="data/reference/GCF_001185365.1_UNIGE_PanGut_3.0_genomic.fna"

gatk --java-options "-Xmx400G" HaplotypeCaller \
  -R "${REFERENCE}" \
  -I "${RAW_DATA_DIR}/${genome}.rmdups.bam" \
  -O data/gatk/${genome}.g.vcf.gz \
  -ERC GVCF
echo "Haplotype Caller done for ${genome}"

