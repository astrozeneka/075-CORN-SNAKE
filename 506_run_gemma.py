import itertools
import os

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
        print(f"Normal: {nc['normal']}, Case: {nc['case']}")
        sample_list_content = """AMEL_106.sorted
AMEL_13.sorted
AMEL_14.sorted
AMEL_15.sorted
AMEL_20.sorted
AMEL_23.sorted
AMEL_28.sorted
AMEL_29.sorted
AMEL_30.sorted
AMEL_44.sorted
AMEL_48.sorted
AMEL_51.sorted
AMEL_71.sorted
AMEL_77.sorted
AMEL_84.sorted
AMEL_96.sorted
AMEL_97.sorted
AMEL_99.sorted
NOR_10.sorted
NOR_11.sorted
NOR_12.sorted
NOR_4.sorted
NOR_5.sorted
NOR_69.sorted
NOR_73.sorted
NOR_7.sorted"""
        open("data/sample_list.txt", "w").write(sample_list_content)
        # Run bash command
        print(f"bash 505_plink.sh")
        os.system(f"bash 505_plink.sh")
        print("Done")
        break