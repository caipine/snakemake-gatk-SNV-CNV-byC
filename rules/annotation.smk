rule snpeff:
    input:
        "filtered/all.vcf.gz",
    output:
        vcf=report("annotated/all.vcf.gz", caption="../report/vcf.rst", category="Calls"),
        csvstats="snpeff/all.csv"
    log:
        "logs/snpeff.log"
    params:
        reference=config["ref"]["name"],
        extra="-Xmx6g"
    threads: 48
    wrapper:
        "0.27.1/bio/snpeff"
