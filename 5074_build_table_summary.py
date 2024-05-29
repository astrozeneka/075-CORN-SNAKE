import pandas as pd

# Read the Table in csv
df = pd.read_csv("data/snps/TableS1_snp_gene_table.csv")

if __name__ == '__main__':
    output = []
    added_genes = []

    # Only the gene where the distnace is 0
    df = df[df["Distance"] == 0.0]
    # The gene columns doesn't begin with "LOC"
    df = df[~df["Gene"].str.startswith("LOC")]
    for index, row in df.iterrows():
        if row["Gene"] in added_genes:
            continue
        # Create a one-row dataframe
        # Convert row to dictionary
        output.append(dict(row))
        added_genes.append(row["Gene"])

    # Write the output to a new file
    output = pd.DataFrame(output)
    output.to_csv("data/snps/Table1_gene_Summary.csv", index=False)
    print("Done")