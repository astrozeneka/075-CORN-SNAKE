from glob import glob
import pandas as pd
import numpy as np
import os

file_list = glob("data/lmm1_results/*.assoc.txt")
file_list = [a for a in file_list if os.path.basename(a) [:6] == "NOR_vs"]
if __name__ == '__main__':
    sig_list = None
    for file in file_list:
        # Read the tsv file to pandas dataframe, the first row is the header
        basename = os.path.basename(file)
        df = pd.read_csv(file, sep="\t")
        len_row = len(df)
        # append to the sig_list some new rows
        new_rows = df[df["p_wald"] < 0.05 / len_row]
        new_rows["traits"] = basename.replace("NOR_vs_", "").replace(".assoc.txt", "")
        if sig_list is None:
            sig_list = new_rows
        else:
            # Concatenate the new rows to the sig_list
            sig_list = pd.concat([sig_list, new_rows])
    # Save the sig_list to a new file
    sig_list.to_csv("data/snps/sig_snps.tsv", sep="\t", index=False)
    print("Done")
