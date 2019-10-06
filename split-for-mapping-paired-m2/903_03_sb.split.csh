foreach normal ( "`cat 903.normal.list`" )
mv split-to-$normal/called split-to-$normal/called904a
cat <<EOF > split-to-$normal/sb.sh
#!/bin/bash
#SBATCH -J ${normal}            # job name
#SBATCH -o ${normal}.o%j        # output and error file name (%j expands to jobID)
#SBATCH -e ${normal}.e%j.err
#SBATCH -N 1
#SBATCH -n 48
#SBATCH -p normal           # queue (partition) -- normal, development, etc.
#SBATCH -t 48:00:00         # run time (hh:mm:ss) - 1.5 hours
#SBATCH --mail-user=qcai1@mdanderson.org
#SBATCH --mail-type=begin   # email me when the job starts
#SBATCH --mail-type=end     # email me when the job finishes
#SBATCH -A MCL-ibrutinib-resist

cd /scratch/03988/qscai/DNAs/wang/dna-seq-gatk-SNV-71-split/split-to-$normal

bash
 snakemake  --unlock 
 snakemake --cores 48  --rerun-incomplete 
 snakemake  --unlock
 snakemake --cores 48  --rerun-incomplete

 snakemake  --unlock
 snakemake --cores 48  --rerun-incomplete

EOF

sbatch  split-to-$normal/sb.sh

end
