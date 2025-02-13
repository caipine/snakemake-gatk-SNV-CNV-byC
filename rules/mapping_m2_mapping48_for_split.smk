rule trim_reads_se:
    input:
        unpack(get_fastq)
    output:
        "../../trimmed/{sample}-{unit}.fastq.gz"
    params:
        extra="",
        **config["params"]["trimmomatic"]["se"]
    log:
        "../../logs/trimmomatic/{sample}-{unit}.log"
    wrapper:
        "0.30.0/bio/trimmomatic/se"


rule trim_reads_pe:
    input:
        unpack(get_fastq)
    output:
        r1="../../trimmed/{sample}-{unit}.1.fastq.gz",
        r2="../../trimmed/{sample}-{unit}.2.fastq.gz",
        r1_unpaired="../../trimmed/{sample}-{unit}.1.unpaired.fastq.gz",
        r2_unpaired="../../trimmed/{sample}-{unit}.2.unpaired.fastq.gz",
        trimlog="../../trimmed/{sample}-{unit}.trimlog.txt"
    params:
        extra=lambda w, output: "-trimlog {}".format(output.trimlog),
        **config["params"]["trimmomatic"]["pe"]
    log:
        "../../logs/trimmomatic/{sample}-{unit}.log"
    wrapper:
        "0.35.1/bio/trimmomatic/pe"


rule map_reads:
    input:
        reads=get_trimmed_reads
    output:
        "../../mapped/{sample}-{unit}.sorted.bam"
    log:
        "../../logs/bwa_mem/{sample}-{unit}.log"
    params:
        index=config["ref"]["genome"],
        extra=get_read_group,
        sort="samtools",
        sort_order="coordinate"
    threads: 48
#    wrapper:
#        "0.27.1/bio/bwa/mem"
    shell:
       """
       bwa mem -t {threads} {params.extra}  {params.index} {input} | samtools sort -@8 -o {output}
       """

rule mark_duplicates:
    input:
        "../../mapped/{sample}-{unit}.sorted.bam"
    output:
        bam="../../dedup/{sample}-{unit}.bam",
        metrics="../../qc/dedup/{sample}-{unit}.metrics.txt"
    log:
        "../../logs/picard/dedup/{sample}-{unit}.log"
    params:
        config["params"]["picard"]["MarkDuplicates"]
    threads: 24
    wrapper:
        "0.26.1/bio/picard/markduplicates"


rule recalibrate_base_qualities:
    input:
        bam=get_recal_input(),
        bai=get_recal_input(bai=True),
        ref=config["ref"]["genome"],
        known=config["ref"]["known-variants"]
    output:
        bam="../../recal/{sample}-{unit}.bam"
    params:
        extra=get_regions_param() + config["params"]["gatk"]["BaseRecalibrator"]
    log:
        "../../logs/gatk/bqsr/{sample}-{unit}.log"
    threads: 24
    wrapper:
        "0.27.1/bio/gatk/baserecalibrator"


rule samtools_index:
    input:
        "../../recal/{sample}-{unit}.bam"
    output:
        "../../recal/{sample}-{unit}.bam.bai"
    wrapper:
        "0.27.1/bio/samtools/index"
