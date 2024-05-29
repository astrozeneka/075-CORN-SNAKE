import pandas as pd

gene_data = pd.read_csv("data/snps/vicinity_genes.tsv", sep="\t")
gene_data = gene_data.sort_values("distance")
snp_sig = pd.read_csv("data/snps/sig_snps.tsv", sep="\t")
snp_sig = snp_sig.sort_values("p_wald")
unique_snp_sig = snp_sig[["rs", "ps"]].drop_duplicates()
print()

# Table S1. The table for the list of SNPS and the nearest gene
# 0. Traits
# 1. Scaffold
# 2. Id
# 3. Position
# 4. Allele1
# 5. Allele0
# 6. P-wald (COMB.1)
# 8. Fasta representation + annotated (svg) (ไม่ต้อง)
# 9. Distance_kb
# 10. Gene
# 11. Gene Description (ไม่ต้อง)
# 10. Primer 1 (ไม่ต้อง)
# 11. Primer 2 (ไม่ต้อง)
if __name__ == '__main__':
    output = []
    added_snps = []
    for index, snp in snp_sig.iterrows():
        row = {
            "Traits": snp["traits"].replace(".gemma_lmm1", "").replace("_", ","),
            "Scaffold": snp["chr"],
            "Id": snp["rs"],
            "Position": snp["ps"],
            "Allele1": snp["allele1"],
            "Allele0": snp["allele0"],
            "P-wald": snp["p_wald"],
            "Distance": None,
            "Gene": None,
            "GeneId": None,
        }
        gene = gene_data[gene_data["rs"] == snp["rs"]]
        # IF there is more than 1 row
        if len(gene) >= 1:
            gene = gene.iloc[0]
            row["Distance"] = gene["distance"]
            gene_attr = gene["attributes"] # ie. ID=gene-NHS;Dbxref=GeneID:117675684;Name=NHS;gbkey=Gene;gene=NHS;gene_biotype=protein_coding"
            gene_attr = gene_attr.split(";")
            gene_attr = [a.split("=") for a in gene_attr]
            gene_attr = {a[0]:a[1] for a in gene_attr}
            row["Gene"] = gene_attr["gene"]
            row["GeneId"] = gene_attr["Dbxref"].replace("GeneID:", "")
        if snp["rs"] not in added_snps:
            added_snps.append(snp["rs"])
            output.append(row)

    output = pd.DataFrame(output)
    output.to_csv("data/snps/TableS1_snp_gene_table.csv", index=False)
