vcf_files_ch = Channel.fromPath(params.sequence_data)

include {SPLIT_SITES} from '../modules/local/split'
include {FILTER_ALLELE_FREQUENCY} from '../modules/local/filter-af'
include {APPLICATION} from '../modules/local/apply-to-file'

workflow PREPROCESS {
    SPLIT_SITES (vcf_files_ch)
    FILTER_ALLELE_FREQUENCY(SPLIT_SITES.out.input_extract)
    APPLICATION(SPLIT_SITES.out.file_split, FILTER_ALLELE_FREQUENCY.out.output_ID_list)
}