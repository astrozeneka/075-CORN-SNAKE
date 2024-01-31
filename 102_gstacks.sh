#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 32
#SBATCH -t 5-00:00:00
#SBATCH --mem=400G
#SBATCH -J gstacks
#SBATCH -A proj5034

module load foss/2021b
export PATH=$PATH:/tarafs/data/project/proj5034-AGBKU/local/bin/

mkdir -p data/gstacks

# 1. the popmap file
# use the << directive to write in a file
cat <<EOF > popmap.txt
AMEL_106.rmdup	AMEL
AMEL_13.rmdup	AMEL
AMEL_14.rmdup	AMEL
AMEL_15.rmdup	AMEL
AMEL_20.rmdup	AMEL
AMEL_23.rmdup	AMEL
AMEL_28.rmdup	AMEL
AMEL_29.rmdup	AMEL
AMEL_30.rmdup	AMEL
AMEL_44.rmdup	AMEL
AMEL_48.rmdup	AMEL
AMEL_51.rmdup	AMEL
AMEL_71.rmdup	AMEL
AMEL_77.rmdup	AMEL
AMEL_84.rmdup	AMEL
AMEL_96.rmdup	AMEL
AMEL_97.rmdup	AMEL
AMEL_99.rmdup	AMEL
CIN_42.rmdup	CIN
HYPO_19.rmdup	HYPO
HYPO_25.rmdup	HYPO
HYPO_26.rmdup	HYPO
HYPO_27.rmdup	HYPO
HYPO_32.rmdup	HYPO
HYPO_34.rmdup	HYPO
HYPO_37.rmdup	HYPO
HYPO_43.rmdup	HYPO
HYPO_47.rmdup	HYPO
HYPO_93.rmdup	HYPO
LVD_102.rmdup	LVD
LVD_16.rmdup	LVD
LVD_17.rmdup	LVD
LVD_18.rmdup	LVD
LVD_21.rmdup	LVD
LVD_22.rmdup	LVD
LVD_24.rmdup	LVD
LVD_33.rmdup	LVD
LVD_3.rmdup	LVD
LVD_45.rmdup	LVD
NOR_10.rmdup	NOR
NOR_11.rmdup	NOR
NOR_12.rmdup	NOR
NOR_4.rmdup	NOR
NOR_5.rmdup	NOR
NOR_69.rmdup	NOR
NOR_73.rmdup	NOR
NOR_7.rmdup	NOR
OPAL_46.rmdup	OPAL
SUN_35.rmdup	SUN
TES_31.rmdup	TES
TES_49.rmdup	TES
TES_8.rmdup	TES
EOF


# 2. Run the Gstacks pipeline
BAM_DIR="/tarafs/data/home/hrasoara/Projects/075-CORN-SNAKE/data/X401SC21090035-Z01-F001_01/02.Bam"
gstacks-I "${BAM_DIR}" \
  -M popmap.txt \
  -O data/gstacks \
  -t 32
echo "Gstacks Done"
