#tcsh

foreach normal ( "`cat 903.normal.list`" )
echo $normal
#end
# setenv normal MCL40
##########################################
cat <<EOFA > 828_Snakefile-to-${normal}-batch

include: "rules/common2.smk"

ALL_mkdir = expand("split-to-${normal}/config.yaml")
ALL_cp = expand("split-to-${normal}/Snakefile")

TARGETS = []
TARGETS.extend(ALL_mkdir)
TARGETS.extend(ALL_cp)

rule all:
     input: TARGETS

rule mkdir:
    input:
      config=    "config.yaml_for_split",
      common=    "rules/common2_for_split.smk",
      mappin=    "rules/mapping_m2_mapping24_for_split.smk",
      bedops=    "envs/bedops.yaml",
      rbt=       "envs/rbt.yaml",
      stats=     "envs/stats.yaml",
      confsch=   "schemas/config.schema.yaml",
      samplesch= "schemas/samples.schema.yaml",
      unitsch=   "schemas/units.schema.yaml",
      units=     config["units"]
      
    output:
      config=    "split-to-${normal}/config.yaml",
      common=    "split-to-${normal}/rules/common2_for_split.smk",
      mappin=    "split-to-${normal}/rules/mapping_m2_mapping24_for_split.smk",
      units=     "split-to-${normal}/units.tsv",
      bedops=    "split-to-${normal}/envs/bedops.yaml",
      rbt=       "split-to-${normal}/envs/rbt.yaml",
      stats=     "split-to-${normal}/envs/stats.yaml",
      confsch=   "split-to-${normal}/schemas/config.schema.yaml",  
      samplesch= "split-to-${normal}/schemas/samples.schema.yaml",  
      unitsch=   "split-to-${normal}/schemas/units.schema.yaml"
      
    shell:
        """
        cp {input.config} {output.config}
        cp {input.common} {output.common}
        cp {input.mappin} {output.mappin}
        cp {input.bedops} {output.bedops}
        cp {input.rbt} {output.rbt}
        cp {input.stats} {output.stats}
        cp {input.confsch} {output.confsch}
        cp {input.samplesch} {output.samplesch}
        cp {input.unitsch} {output.unitsch}
        cp {input.units} {output.units}
        """

rule cp:
     input:
       snakefile="903_Snakefile_inside_one_layer",
       samplefile=config["samples"]
     output:
       snakefile="split-to-${normal}/Snakefile",
       samplefile="split-to-${normal}/samples.tsv"   
     shell:
       """
        cp {input.snakefile} {output.snakefile}
        cp {input.samplefile} {output.samplefile}
       """
EOFA

snakemake --snakefile 828_Snakefile-to-${normal}-batch


end
