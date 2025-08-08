/*
========================================================================================
    LauSchoe/split-multiallelic-sites-nf
========================================================================================
    Github : https://github.com/LauSchoe/split-multiallelic-sites-nf
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