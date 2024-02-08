#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J gemma

source ~/.bashrc
conda activate /tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/conda-envs/gemma

phenotype="LVD"
mkdir -p data/plink

# create the sample_id list file that will be used by plink using cat and pipe
cat <<EOF > "data/${phenotype}_samples.txt"
LVD_21.rmdup LVD_21.rmdup
LVD_24.rmdup LVD_24.rmdup
LVD_33.rmdup LVD_33.rmdup
LVD_102.rmdup LVD_102.rmdup
LVD_16.rmdup LVD_16.rmdup
LVD_17.rmdup LVD_17.rmdup
LVD_18.rmdup LVD_18.rmdup
LVD_22.rmdup LVD_22.rmdup
LVD_45.rmdup LVD_45.rmdup
NOR_69.rmdup NOR_69.rmdup
NOR_7.rmdup NOR_7.rmdup
NOR_11.rmdup NOR_11.rmdup
NOR_12.rmdup NOR_12.rmdup
NOR_4.rmdup NOR_4.rmdup
NOR_10.rmdup NOR_10.rmdup
NOR_5.rmdup NOR_5.rmdup
LVD_3.rmdup LVD_3.rmdup
NOR_73.rmdup NOR_73.rmdup
EOF

# Run the plink by using the sample_id list file
/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares/plink \
  --allow-extra-chr --make-bed --double-id --threads 96 \
  --vcf data/populations/populations.snps.vcf \
  --keep data/${phenotype}_samples.txt \
  --out data/plink/${phenotype}_plink

cat <<EOF >data/plink/${phenotype}_plink.fam
LVD_21.rmdup LVD_21.rmdup 0 0 0 2
LVD_24.rmdup LVD_24.rmdup 0 0 0 2
LVD_33.rmdup LVD_33.rmdup 0 0 0 2
LVD_102.rmdup LVD_102.rmdup 0 0 0 2
LVD_16.rmdup LVD_16.rmdup 0 0 0 2
LVD_17.rmdup LVD_17.rmdup 0 0 0 2
LVD_18.rmdup LVD_18.rmdup 0 0 0 2
LVD_22.rmdup LVD_22.rmdup 0 0 0 2
LVD_45.rmdup LVD_45.rmdup 0 0 0 2
NOR_69.rmdup NOR_69.rmdup 0 0 0 1
NOR_7.rmdup NOR_7.rmdup 0 0 0 1
NOR_11.rmdup NOR_11.rmdup 0 0 0 1
NOR_12.rmdup NOR_12.rmdup 0 0 0 1
NOR_4.rmdup NOR_4.rmdup 0 0 0 1
NOR_10.rmdup NOR_10.rmdup 0 0 0 1
NOR_5.rmdup NOR_5.rmdup 0 0 0 1
LVD_3.rmdup LVD_3.rmdup 0 0 0 2
NOR_73.rmdup NOR_73.rmdup 0 0 0 1
EOF

cat<<EOF >data/plink/${phenotype}_plink.fam
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
1
0
EOF


# 2. Run Gemma Part 1
echo "Gemma part 1"
gemma -bfile data/plink/${phenotype}_plink \
  -gk 1 \
  -p data/${phenotype}_phenos.txt \
  -o gemma_kinship
echo "Gemma part 1 done"

# 3. Run Gemma Part 2
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