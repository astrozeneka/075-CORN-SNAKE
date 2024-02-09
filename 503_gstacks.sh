#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 32
#SBATCH -t 5-00:00:00
#SBATCH --mem=400G
#SBATCH -J gstacks
#SBATCH -A proj5034

module load foss/2021b
export PATH=$PATH:/tarafs/data/project/proj5034-AGBKU/local/bin/


cat <<EOF > popmap.txt
AMEL_106.sorted	AMEL
AMEL_13.sorted	AMEL
AMEL_14.sorted	AMEL
AMEL_15.sorted	AMEL
AMEL_20.sorted	AMEL
AMEL_23.sorted	AMEL
AMEL_28.sorted	AMEL
AMEL_29.sorted	AMEL
AMEL_30.sorted	AMEL
AMEL_44.sorted	AMEL
AMEL_48.sorted	AMEL
AMEL_51.sorted	AMEL
AMEL_71.sorted	AMEL
AMEL_77.sorted	AMEL
AMEL_84.sorted	AMEL
AMEL_96.sorted	AMEL
AMEL_97.sorted	AMEL
AMEL_99.sorted	AMEL
CIN_42.sorted	CIN
HYPO_19.sorted	HYPO
HYPO_25.sorted	HYPO
HYPO_26.sorted	HYPO
HYPO_27.sorted	HYPO
HYPO_32.sorted	HYPO
HYPO_34.sorted	HYPO
HYPO_37.sorted	HYPO
HYPO_43.sorted	HYPO
HYPO_47.sorted	HYPO
HYPO_93.sorted	HYPO
LVD_102.sorted	LVD
LVD_16.sorted	LVD
LVD_17.sorted	LVD
LVD_18.sorted	LVD
LVD_21.sorted	LVD
LVD_22.sorted	LVD
LVD_24.sorted	LVD
LVD_33.sorted	LVD
LVD_3.sorted	LVD
LVD_45.sorted	LVD
NOR_10.sorted	NOR
NOR_11.sorted	NOR
NOR_12.sorted	NOR
NOR_4.sorted	NOR
NOR_5.sorted	NOR
NOR_69.sorted	NOR
NOR_73.sorted	NOR
NOR_7.sorted	NOR
OPAL_46.sorted	OPAL
SUN_35.sorted	SUN
TES_31.sorted	TES
TES_49.sorted	TES
TES_8.sorted	TES
EOF

mkdir -p data/onref_stacks
gstacks -I "data/onref_map" -M popmap.txt -O data/onref_stacks -t 32
echo "gstacks done"
