#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J gemma

conda activate /tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/conda-envs/gemma

mkdir -p data/plink
plink --allow-extra-chr --make-bed --double-id --threads 96 \
  --vcf data/populations/populations.snps.vcf \
  --out data/plink/plink
echo "Plink done"

# This is an example that highlight the Lavender phenotype
phenofile="phenotype.txt"
cat <<EOF > "${phenofile}"
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
1
1
1
1
1
1
1
1
1
1
0
0
0
0
0
0
0
0
0
0
0
0
0
EOF

gemma -bfile data/plink/plink \
  -k kinship -lmm 1 -p "${phenofile}" -o gemma-output
