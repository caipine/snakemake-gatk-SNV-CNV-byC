rule fastqc:
    input:
        unpack(get_fastq)
    output:
        html="qc/fastqc/{sample}-{unit}.html",
        zip="qc/fastqc/{sample}-{unit}.zip"
    params: ""
    log:
        "logs/fastqc/{sample}-{unit}.log"
    wrapper:
        "0.35.1/bio/fastqc"


rule samtools_stats:
    input:
        "recal/{sample}-{unit}.bam"
    output:
        "qc/samtools-stats/{sample}-{unit}.txt"
    log:
        "logs/samtools-stats/{sample}-{unit}.log"
    wrapper:
        "0.35.1/bio/samtools/stats"



rule multiqc:
    input:
#        expand(["qc/samtools-stats/{u.sample}-{u.unit}.txt"], u=units.itertuples()),
#        expand("qc/samtools_stats/{sample}.txt", sample=["MCL55-tumor", "MCL55-control"])
    output:
        "qc/multiqc.html"
    params:
        ""  # Optional: extra parameters for multiqc.
    log:
        "logs/multiqc.log"
    wrapper:
        "0.35.1/bio/multiqc"
