#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 96:00:00
#SBATCH -J bam_split
#SBATCH -A proj5057

module purge
module load bzip2/1.0.8-GCCcore-10.2.0
module load ncurses/6.2-GCCcore-10.2.0
module load foss/2021b
export PATH=$PATH:/tarafs/data/home/hrasoara/softwares/samtools-1.18/

genomes=(
  "AMEL_106"
  "AMEL_13"
  "AMEL_14"
  "AMEL_15"
  "AMEL_20"
  "AMEL_23"
  "AMEL_28"
  "AMEL_29"
  "AMEL_30"
  "AMEL_44"
  "AMEL_48"
  "AMEL_51"
  "AMEL_71"
  "AMEL_77"
  "AMEL_84"
  "AMEL_96"
  "AMEL_97"
  "AMEL_99"
  "CIN_42"
  "HYPO_19"
  "HYPO_25"
  "HYPO_26"
  "HYPO_27"
  "HYPO_32"
  "HYPO_34"
  "HYPO_37"
  "HYPO_43"
  "HYPO_47"
  "HYPO_93"
  "LVD_102"
  "LVD_16"
  "LVD_17"
  "LVD_18"
  "LVD_21"
  "LVD_22"
  "LVD_24"
  "LVD_3"
  "LVD_33"
  "LVD_45"
  "NOR_10"
  "NOR_11"
  "NOR_12"
  "NOR_4"
  "NOR_5"
  "NOR_69"
  "NOR_7"
  "NOR_73"
  "OPAL_46"
  "SUN_35"
  "TES_31"
  "TES_49"
  "TES_8"
)

RAW_DATA_DIR="/tarafs/data/home/hrasoara/Projects/075-CORN-SNAKE/data/X401SC21090035-Z01-F001_01/02.Bam"
for genome in "${genomes[@]}"
do
  samtools index -@ 96 "${RAW_DATA_DIR}/${genome}/${genome}.bam"
done
echo "BAM index done"
