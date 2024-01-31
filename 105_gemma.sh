#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J gemma

source ~/.bashrc
conda activate /tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/conda-envs/gemma

mkdir -p data/plink
/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares/plink \
  --allow-extra-chr --make-bed --double-id --threads 96 \
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

# 2. Run Gemma part 1
echo "Gemma part 1"
gemma -bfile data/plink/plink \
  -gk 1 -p "${phenofile}" -o gemma_kinship

# 3. Run Gemma part 2
echo "Gemma part 2"
gemma -bfile data/plink/plink \
  -p "${phenofile}" -n 1 \
  -k ./output/gemma_kinship.cXX.txt -lmm 1 -o gemma_lmm1

# 4. Store the result
mkdir -p data/gemma/01-LAV
mv ./output/* data/gemma/01-LAV/

echo "Done"
