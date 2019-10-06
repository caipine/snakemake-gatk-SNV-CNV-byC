foreach sample ( "`cat samples.4.tsv`" )
mv split/$sample/called split/$sample/called_wrong

cat <<EOF > split/$sample/sb.sh
#!/bin/bash
#SBATCH -J ${sample}            # job name
#SBATCH -o ${sample}.o%j        # output and error file name (%j expands to jobID)
#SBATCH -e ${sample}.e%j.err
#SBATCH -N 1
#SBATCH -n 48
#SBATCH -p normal           # queue (partition) -- normal, development, etc.
#SBATCH -t 48:00:00         # run time (hh:mm:ss) - 1.5 hours
#SBATCH --mail-user=qcai1@mdanderson.org
#SBATCH --mail-type=begin   # email me when the job starts
#SBATCH --mail-type=end     # email me when the job finishes
#SBATCH -A MCL-ibrutinib-resist

cd /scratch/03988/qscai/DNAs/wang/dna-seq-gatk-52-55/split/$sample
bash
 snakemake  --unlock 
 snakemake --cores 48  --rerun-incomplete

 snakemake  --unlock
 snakemake --cores 48  --rerun-incomplete

 snakemake  --unlock
 snakemake --cores 48  --rerun-incomplete

 snakemake  --unlock
 snakemake --cores 48  --rerun-incomplete

 snakemake  --unlock
 snakemake --cores 48  --rerun-incomplete


EOF

#sbatch  split/$sample/sb.sh

end
