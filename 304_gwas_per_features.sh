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

