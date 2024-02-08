#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J gemma

source ~/.bashrc
conda activate /tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/conda-envs/gemma

phenotype="HYPO"
mkdir -p data/plink

# create the sample_id list file that will be used by plink using cat and pipe
cat <<EOF > "data/${phenotype}_samples.txt"
HYPO_26.rmdup HYPO_26.rmdup
HYPO_27.rmdup HYPO_27.rmdup
HYPO_37.rmdup HYPO_37.rmdup
HYPO_43.rmdup HYPO_43.rmdup
HYPO_19.rmdup HYPO_19.rmdup
HYPO_47.rmdup HYPO_47.rmdup
HYPO_93.rmdup HYPO_93.rmdup
NOR_69.rmdup NOR_69.rmdup
NOR_7.rmdup NOR_7.rmdup
NOR_11.rmdup NOR_11.rmdup
NOR_12.rmdup NOR_12.rmdup
NOR_4.rmdup NOR_4.rmdup
NOR_10.rmdup NOR_10.rmdup
NOR_5.rmdup NOR_5.rmdup
HYPO_25.rmdup HYPO_25.rmdup
HYPO_32.rmdup HYPO_32.rmdup
HYPO_34.rmdup HYPO_34.rmdup
NOR_73.rmdup NOR_73.rmdup
EOF

# Run the plink by using the sample_id list file
/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares/plink \
  --allow-extra-chr --make-bed --double-id --threads 96 \
  --vcf data/populations/populations.snps.vcf \
  --keep data/${phenotype}_samples.txt \
  --out data/plink/${phenotype}_plink

# Update the fam file
cat <<EOF >data/plink/${phenotype}_plink.fam
HYPO_26.rmdup HYPO_26.rmdup 0 0 0 2
HYPO_27.rmdup HYPO_27.rmdup 0 0 0 2
HYPO_37.rmdup HYPO_37.rmdup 0 0 0 2
HYPO_43.rmdup HYPO_43.rmdup 0 0 0 2
HYPO_19.rmdup HYPO_19.rmdup 0 0 0 2
HYPO_47.rmdup HYPO_47.rmdup 0 0 0 2
HYPO_93.rmdup HYPO_93.rmdup 0 0 0 2
NOR_69.rmdup NOR_69.rmdup 0 0 0 1
NOR_7.rmdup NOR_7.rmdup 0 0 0 1
NOR_11.rmdup NOR_11.rmdup 0 0 0 1
NOR_12.rmdup NOR_12.rmdup 0 0 0 1
NOR_4.rmdup NOR_4.rmdup 0 0 0 1
NOR_10.rmdup NOR_10.rmdup 0 0 0 1
NOR_5.rmdup NOR_5.rmdup 0 0 0 1
HYPO_25.rmdup HYPO_25.rmdup 0 0 0 2
HYPO_32.rmdup HYPO_32.rmdup 0 0 0 2
HYPO_34.rmdup HYPO_34.rmdup 0 0 0 2
NOR_73.rmdup NOR_73.rmdup 0 0 0 1
EOF

cat <<EOF > "data/${phenotype}_phenos.txt"
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
1
1
1
0
EOF

# 3. Run Gemma Part 1
echo "Gemma part 1"
gemma -bfile data/plink/${phenotype}_plink \
  -gk 1 \
  -p data/${phenotype}_phenos.txt \
  -o gemma_kinship
echo "Gemma part 1 done"

# 4. Run Gemma Part 2
echo "Gemma part 2"
gemma -bfile data/plink/${phenotype}_plink \
  -p data/${phenotype}_phenos.txt \
  -k output/gemma_kinship.cXX.txt \
  -lmm 1 \
  -o gemma_lmm1
echo "Gemma part 2 done"

# 4. Store the result
mkdir -p data/gemma/${phenotype}
mv ./output/* data/gemma/${phenotype}/

echo "Done"