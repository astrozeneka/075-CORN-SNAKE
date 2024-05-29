import pandas as pd

if __name__ == '__main__':
    data = open("data/6.Genotyping/Genotyping.anno.xls.head.txt").read().strip().split("\n")
    data = [a.split("\t") for a in data]
    data = pd.DataFrame(data[1:], columns=data[0])
    print()