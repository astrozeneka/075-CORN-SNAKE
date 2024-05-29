import pandas as pd

# Load the GFF data
gff = open("data/genomic.gff").read().strip().split("\n")
gff = [a for a in gff if a[0] != "#"]
# Load into pandas dataframe
gff = [a.split("\t") for a in gff]
gff = pd.DataFrame(gff, columns=["chr", "source", "type", "start", "end", "score", "strand", "phase", "attributes"])
gff["start"] = gff["start"].astype(int)
gff["end"] = gff["end"].astype(int)
print("GFF loaded")

if __name__ == '__main__':
    snps = pd.read_csv("data/snps/sig_snps.tsv", sep="\t")
    # Only get unique values of the rs column with the corresponding row
    snps = snps[["chr", "rs", "ps"]].drop_duplicates()
    # Save the unique values to a new file

    vicinity_genes = None # Within 100k bp from the left and right of the locus
    direct_genes = None
    for index, row in snps.iterrows():

        # Direct gene
        pot_direct_region = gff[(gff["chr"] == row["chr"]) & (gff["start"] < row["ps"]) & (gff["end"] > row["ps"])]
        pot_direct_region = pot_direct_region[pot_direct_region["type"] == "gene"]
        pot_direct_region["distance"] = 0 # Because it is within the gene
        pot_direct_region["rs"] = row["rs"]
        if direct_genes is None:
            direct_genes = pot_direct_region
        else:
            direct_genes = pd.concat([direct_genes, pot_direct_region])

        # Genes in a vicinity of 100kbp left and 100kbp right
        pot_vicinity_region = gff[(gff["chr"] == row["chr"]) & (gff["start"] < row["ps"] + 100000) & (gff["end"] > row["ps"] - 100000)]
        pot_vicinity_region = pot_vicinity_region[pot_vicinity_region["type"] == "gene"]
        pot_vicinity_region["distance"] = pot_vicinity_region.apply(lambda x: min(abs(x["start"] - row["ps"]), abs(x["end"] - row["ps"])), axis=1)
        pot_vicinity_region["rs"] = row["rs"]
        if vicinity_genes is None:
            vicinity_genes = pot_direct_region # The direct region is included in the vicinity region
        else:
            vicinity_genes = pd.concat([vicinity_genes, pot_direct_region])
            vicinity_genes = pd.concat([vicinity_genes, pot_vicinity_region])

    # output to tsv the two gene list
    direct_genes.to_csv("data/snps/direct_genes.tsv", sep="\t", index=False)
    vicinity_genes.to_csv("data/snps/vicinity_genes.tsv", sep="\t", index=False)

    print("Done")