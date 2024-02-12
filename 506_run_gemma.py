import itertools
import os

popmap = """AMEL_106.sorted	AMEL
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
TES_8.sorted	TES""".split("\n")
popmap = [a.split() for a in popmap]

phenotypes = [
    "AMEL",
    "HYPO",
    "LVD",
    "NOR",
    "LVD",
    "TES",
    "SUN",
    "CIN",
    "OPAL"
]
if __name__ == '__main__':
    # The final [normal, case] doesn't contain forcely all phenotypes
    normal_case_list = []
    for i in range(1, len(phenotypes) - 1):
        combinations = list(itertools.combinations(phenotypes, i))
        combinations = [a for a in combinations if "NOR" in a] # Normal case should include the "NOR" phenotype
        for combination in combinations:
            # remaining_list
            remaining_list = [x for x in phenotypes if x not in combination]
            for j in range(1, len(remaining_list)):
                case_combinations = list(itertools.combinations(remaining_list, j))
                for case_combination in case_combinations:
                    nc = {
                        "normal": combination,
                        "case": case_combination
                    }
                    if(nc not in normal_case_list):
                        normal_case_list.append(nc)

    print(f"{len(normal_case_list)} normal/case combinations are available for GWAS analysis.")
    for nc in normal_case_list:
        nc['normal'] = list(nc['normal'])
        nc['case'] = list(nc['case'])
        slug = "_".join(nc['normal']) + "_vs_" + "_".join(nc['case'])
        print(f"Normal: {nc['normal']}, Case: {nc['case']}")

        # 1. PLINK keep files
        sample_list_content = "\n".join([f"{a[0]}\t{a[1]}" for a in popmap if a[1] in nc['normal'] or a[1] in nc['case']])
        open(f"data/onref_plink/{slug}.samples.txt", "w").write(sample_list_content)

        # 2. Override the PLINK .fam files
        fam_content = ""
        for a in popmap:
            if a[1] in nc['normal']:
                fam_content += f"{a[0]}\t{a[0]}\t0\t0\t0\t1\n"
            elif a[1] in nc['case']:
                fam_content += f"{a[0]}\t{a[0]}\t0\t0\t0\t2\n"
        open(f"data/onref_plink/{slug}._fam", "w").write(fam_content)

        # 3. เตรียม phenofile
        phenofile_content = "\n".join([f"{1 if a[1] in nc['normal'] else 0}" for a in popmap if a[1] in nc['normal'] or a[1] in nc['case']])
        open(f"data/onref_plink/{slug}.phenotype.txt", "w").write(phenofile_content)

        # Run bash command
        print(f"bash 505_plink.sh {slug}")
        os.system(f"bash 505_plink.sh {slug}")
        print("Done")
        break