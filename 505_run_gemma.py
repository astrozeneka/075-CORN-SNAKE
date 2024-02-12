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
    "OPAL",
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

    # Now, we have the list of normal/case combination that can be used for GWAS analysis
    # TODO: should include the sex information
    print()