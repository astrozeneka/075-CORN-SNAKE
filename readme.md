# Corn Snake analysis

## Step 1: BWA index

After building the singularity file, run the following command

```
singularity exec --bind data_copy:/data_copy container.sif /bwa-0.7.15/bwa index /data_copy/GCF_029531705.1_CU_Pguttatus_1_genomic.fna
```
