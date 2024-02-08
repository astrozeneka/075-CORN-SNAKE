#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J gemma

source ~/.bashrc
conda activate /tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/conda-envs/gemma

phenotype="AMEL"
mkdir -p data/plink

# create the sample_id list file that will be used by plink using cat and pipe
cat <<EOF > "data/${phenotype}_samples.txt"
AMEL_13.rmdup AMEL_13.rmdup
AMEL_28.rmdup AMEL_28.rmdup
AMEL_84.rmdup AMEL_84.rmdup
AMEL_96.rmdup AMEL_96.rmdup
AMEL_97.rmdup AMEL_97.rmdup
AMEL_106.rmdup AMEL_106.rmdup
AMEL_14.rumdup AMEL_14.rmdup
AMEL_15.rumdup AMEL_15.rmdup
AMEL_29.rumdup AMEL_29.rmdup
AMEL_44.rumdup AMEL_44.rmdup
AMEL_51.rumdup AMEL_51.rmdup
AMEL_77.rumdup AMEL_77.rmdup
AMEL_99.rumdup AMEL_99.rmdup
NOR_69.rmdup NOR_69.rmdup
NOR_7.rmdup NOR_7.rmdup
NOR_11.rmdup NOR_11.rmdup
NOR_12.rmdup NOR_12.rmdup
NOR_4.rmdup NOR_4.rmdup
NOR_10.rmdup NOR_10.rmdup
NOR_5.rmdup NOR_5.rmdup
AMEL_20.rmdup AMEL_20.rmdup
AMEL_23.rmdup AMEL_23.rmdup
AMEL_30.rmdup AMEL_30.rmdup
AMEL_48.rmdup AMEL_48.rmdup
AMEL_71.rmdup AMEL_71.rmdup
NOR_73.rmdup NOR_73.rmdup
EOF

# Run the plink by using the sample_id list file
/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares/plink \
  --allow-extra-chr --make-bed --double-id --threads 96 \
  --vcf data/populations/populations.snps.vcf \
  --keep data/${phenotype}_samples.txt \
  --out data/plink/${phenotype}_plink

# update the fam file
cat <<EOF >data/plink/${phenotype}_plink.fam
AMEL_106.rmdup AMEL_106.rmdup 0 0 0 2
AMEL_13.rmdup AMEL_13.rmdup 0 0 0 2
AMEL_20.rmdup AMEL_20.rmdup 0 0 0 2
AMEL_23.rmdup AMEL_23.rmdup 0 0 0 2
AMEL_28.rmdup AMEL_28.rmdup 0 0 0 2
AMEL_30.rmdup AMEL_30.rmdup 0 0 0 2
AMEL_48.rmdup AMEL_48.rmdup 0 0 0 2
AMEL_71.rmdup AMEL_71.rmdup 0 0 0 2
AMEL_84.rmdup AMEL_84.rmdup 0 0 0 2
AMEL_96.rmdup AMEL_96.rmdup 0 0 0 2
AMEL_97.rmdup AMEL_97.rmdup 0 0 0 2
NOR_10.rmdup NOR_10.rmdup 0 0 0 1
NOR_11.rmdup NOR_11.rmdup 0 0 0 1
NOR_12.rmdup NOR_12.rmdup 0 0 0 1
NOR_4.rmdup NOR_4.rmdup 0 0 0 1
NOR_5.rmdup NOR_5.rmdup 0 0 0 1
NOR_69.rmdup NOR_69.rmdup 0 0 0 1
NOR_73.rmdup NOR_73.rmdup 0 0 0 1
NOR_7.rmdup NOR_7.rmdup 0 0 0 1
EOF

cat <<EOF > "data/${phenotype}_phenos.txt"
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
1
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

