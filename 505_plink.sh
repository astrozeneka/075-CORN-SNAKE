#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J plink
#SBATCH -A proj5034

export PATH=$PATH:/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares

slug=$1

/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares/plink \
  --allow-extra-chr --make-bed --double-id --threads 96 \
  --vcf data/onref_populations/populations.snps.vcf \
  --keep data/onref_plink/${slug}.samples.txt \
  --out data/onref_plink/plink
echo "Plink done"

# Override the fam .file
mv data/onref_plink/${slug}._fam data/onref_plink/${slug}.fam

