import itertools

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
        print()