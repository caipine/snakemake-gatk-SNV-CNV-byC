foreach normal ( "`cat 903.normal.list`" )

cat <<EOF > split-to-${normal}/rules/to-unpaired-normal.smk


rule call_variants_Mutect2:
    input:
        control="/scratch/03988/qscai/DNAs/wang/dna-seq-gatk-SNV-71-split/recal/${normal}-control.bam",
        tumor= "../recal/{sample}-tumor.bam",
        ref=config["ref"]["genome"],
        pon=config["ref"]["pon"],
        germline=config["ref"]["germline"],
        intervallist=config["ref"]["interval_list"]
    params:
        head_tumor="{sample}_tumor",
        head_control="${normal}_control"
    output:
        gvcf="called/{sample}.1_somatic_m2.vcf.gz",
        bamout="called/{sample}.2_tumor_normal_m2.bam"
    threads:6
    shell:
        """
        gatk --java-options "-Xmx2g" Mutect2\
        -R {input.ref} \
        -I {input.tumor} \
        -I {input.control} \
        -tumor {params.head_tumor} \
        -normal {params.head_control} \
        -pon {input.pon} \
        --germline-resource {input.germline} \
        --af-of-alleles-not-in-resource 0.0000025 \
        --disable-read-filter MateOnSameContigOrNoMappedMateReadFilter \
        -L {input.intervallist} \
        -O {output.gvcf} \
        -bamout {output.bamout}
        """
EOF

end


