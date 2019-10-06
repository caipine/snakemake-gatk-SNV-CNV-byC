gatk PreprocessIntervals \
    -L cnv/S31285117_AllTracks.hg38.interval_list \
    -XL cnv/CNV_and_centromere_blacklist.hg38liftover.list \
    --sequence-dictionary /scratch/03988/qscai/DNAs/hg38/Homo_sapiens_assembly38.dict \
    -R /scratch/03988/qscai/DNAs/hg38/Homo_sapiens_assembly38.fasta \
    --bin-length 0 \
    --interval-merging-rule OVERLAPPING_ONLY \
    -O cnv/S31285117_AllTracks.hg38.preprocessed.interval_list
