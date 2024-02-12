#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J plink
#SBATCH -A proj5034

export PATH=$PATH:/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares

# TODO: Update the sample_list.txt file
mkdir -p data/onref_plink
/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares/plink \
  --allow-extra-chr --make-bed --double-id --threads 96 \
  --vcf data/onref_populations/populations.snps.vcf \
  --keep data/sample_list.txt \
  --out data/onref_plink/plink
echo "Plink done"