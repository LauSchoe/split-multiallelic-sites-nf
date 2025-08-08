/*
========================================================================================
    LauSchoe/split_multiallelic_sites
========================================================================================
    Github : https://github.com/LauSchoe/split_multiallelic_sites
    Author: Laura Schöttle
    ---------------------------
*/

nextflow.enable.dsl = 2

if(params.outdir == null) {
    params.pubDir = "output/${params.project}"
} else {
    params.pubDir = params.outdir
}

include {PREPROCESS} from './workflows/split-multiallelic'

workflow{
    PREPROCESS ()
}