#!/bin/bash
#SBATCH -J 71            # job name
#SBATCH -o 71.o%j        # output and error file name (%j expands to jobID)
#SBATCH -e 71.e%j.err
#SBATCH -N 1
#SBATCH -n 48
#SBATCH -p normal           # queue (partition) -- normal, development, etc.
#SBATCH -t 48:00:00         # run time (hh:mm:ss) - 1.5 hours
#SBATCH --mail-user=qcai1@mdanderson.org
#SBATCH --mail-type=begin   # email me when the job starts
#SBATCH --mail-type=end     # email me when the job finishes
#SBATCH -A MCL-ibrutinib-resist

cd /scratch/03988/qscai/DNAs/wang/dna-seq-gatk-SNV-71

bash
 snakemake --unlock --snakefile Snakefile_m2_trimANDmapping 
 snakemake --snakefile Snakefile_m2_trimANDmapping  --cores 48  --rerun-incomplete

 snakemake --unlock --snakefile Snakefile_m2_trimANDmapping
 snakemake --snakefile Snakefile_m2_trimANDmapping  --cores 48  --rerun-incomplete

 snakemake --unlock --snakefile Snakefile_m2_trimANDmapping
 snakemake --snakefile Snakefile_m2_trimANDmapping  --cores 48  --rerun-incomplete

 snakemake --unlock --snakefile Snakefile_m2_trimANDmapping
 snakemake --snakefile Snakefile_m2_trimANDmapping  --cores 48  --rerun-incomplete

 snakemake --unlock --snakefile Snakefile_m2_trimANDmapping
 snakemake --snakefile Snakefile_m2_trimANDmapping  --cores 48  --rerun-incomplete


