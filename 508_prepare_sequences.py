
snp_data = """amel_1    AMEL	NW_023010696.1	349613:36:+
amel_2  AMEL	NW_023010748.1	1499114:233:+
amel_3  AMEL	NW_023010696.1	348618:176:+
amel_4  AMEL	NW_023010748.1	1494135:135:+
lvd_1   LVD	NW_023010697.1	424178:73:+
lvd_sun_1    LVD,SUN	NW_023010819.1	2015874:67:+
lvd_sun_2    LVD,SUN	NW_023010819.1	2015874:144:+
lvd_sun_3    LVD,SUN	NW_023010819.1	2015874:50:+
lvd_sun_4    LVD,SUN	NW_023010793.1	1779162:138:-
lvd_sun_5    LVD,SUN	NW_023010819.1	2015874:159:+"""

if __name__ == '__main__':
    snp_data = snp_data.strip().split("\n")
    snp_data = [a.split() for a in snp_data]
    for snp in snp_data:
        fasta_file = f"data/onref_populations/snps/{snp[0]}.fa"
        fasta_sequences = open(fasta_file).read().strip().split("\n")
        snp_offset = int(snp[3].split(":")[1])
        fasta_pre = ""
        for row in fasta_sequences:
            if row[0] == ">":
                fasta_pre += row + "<br/>"
                continue
            # Highlight with html tag the snp
            fasta_pre += row[:snp_offset] + f"<b style='background:yellow'>{row[snp_offset]}</b>" + row[snp_offset+1:] + "<br/>"
        html = f"<html><head><title>{snp[0]}</title></head><body>"
        html += f"<h1>{snp[0]}</h1><code style='font-family: monospace'>{fasta_pre}</code></body></html>"
        open(f"data/onref_populations/snps/{snp[0]}.html", "w").write(html)
    print("Done")

