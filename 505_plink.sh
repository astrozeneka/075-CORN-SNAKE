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
  --out data/onref_plink/${slug}
echo "Plink done"

# Override the fam .file
mv data/onref_plink/${slug}._fam data/onref_plink/${slug}.fam

echo "Gemma part 1"
gemma -bfile data/plink/${slug} \
  -gk 1 \
  -p data/onref_plink/${slug}.phenotype.txt \
  -o gemma_kinship
echo "Gemma part 1 Done"

echo "Gemma part 2"
gemma -bfile data/plink/${slug} \
  -p data/onref_plink/${slug}.phenotype.txt \
  -k output/gemma_kinship.cXX.txt \
  -lmm 1 \
  -o gemma_lmm1
echo "Gemma part 2 Done"

# Store the results
echo "Done"
