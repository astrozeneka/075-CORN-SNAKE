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
cat <<EOF > "${phenotype}_samples.txt"
AMEL_13
AMEL_28
AMEL_84
AMEL_96
AMEL_97
AMEL_106
AMEL_14
AMEL_15
AMEL_29
AMEL_44
AMEL_51
AMEL_77
AMEL_99
NOR_69
NOR_7
NOR_11
NOR_12
NOR_4
NOR_10
NOR_5
AMEL_20
AMEL_23
AMEL_30
AMEL_48
AMEL_71
NOR_73
EOF

# Run the plink by using the sample_id list file
/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares/plink \
  --allow-extra-chr --make-bed --double-id --threads 96 \
  --vcf data/populations/populations.snps.vcf \
  --keep data/${phenotype}_samples.txt \
  --out data/plink/${phenotype}_plink

