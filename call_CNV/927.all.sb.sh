#!/bin/bash
#SBATCH -J pon            # job name
#SBATCH -o pon.o%j        # output and error file name (%j expands to jobID)
#SBATCH -e pon.e%j.err
#SBATCH -N 1
#SBATCH -n 48
#SBATCH -p normal           # queue (partition) -- normal, development, etc.
#SBATCH -t 48:00:00         # run time (hh:mm:ss) - 1.5 hours
#SBATCH --mail-user=qcai1@mdanderson.org
#SBATCH --mail-type=begin   # email me when the job starts
#SBATCH --mail-type=end     # email me when the job finishes
#SBATCH -A MCL-ibrutinib-resist

cd /scratch/03988/qscai/DNAs/wang/dna-seq-gatk-SNV-71-split

bash
snakemake  --unlock  --snakefile 927.02.Snakefile_pon
snakemake --cores 48  --rerun-incomplete  --snakefile 927.02.Snakefile_pon

gatk  CreateReadCountPanelOfNormals \
            --input pon/MCL40-control.counts.hdf5 \
            --input pon/MCL41-control.counts.hdf5 \
            --input pon/MCL42-control.counts.hdf5 \
            --input pon/MCL44-control.counts.hdf5 \
            --input pon/MCL49-control.counts.hdf5 \
            --input pon/MCL50-control.counts.hdf5 \
            --input pon/MCL52-control.counts.hdf5 \
            --input pon/MCL53-control.counts.hdf5 \
            --input pon/MCL54-control.counts.hdf5 \
            --input pon/MCL55-control.counts.hdf5 \
            --input pon/MCL71-control.counts.hdf5 \
            --input pon/MCL73-control.counts.hdf5 \
            --input pon/MCL75-control.counts.hdf5 \
            --input pon/MCL84-control.counts.hdf5 \
            --input pon/MCL85-control.counts.hdf5 \
            --input pon/MCL91-control.counts.hdf5 \
            --input pon/MCL93-control.counts.hdf5 \
            --input pon/MCL56-control.counts.hdf5 \
            --input pon/MCL65-control.counts.hdf5 \
            --input pon/MCL62-control.counts.hdf5 \
            --input pon/MCL63-control.counts.hdf5 \
            --input pon/MCL66-control.counts.hdf5 \
            --input pon/MCL60L1-control.counts.hdf5 \
            --output pon/mcl24.pon.hdf5

snakemake  --unlock --snakefile 927.04.Snakefile_both
snakemake --cores 48  --rerun-incomplete  --snakefile 927.04.Snakefile_both
