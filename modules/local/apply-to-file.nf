process APPLICATION {
    publishDir "${params.pubDir}/test", mode: 'copy', pattern: '*vcf.gz'
    input:
    path original_file
    path ID
    output:
    path "*.vcf.gz", emit: filtered_af

    """
    bcftools view --include ID=@"${ID}" "${original_file}" -Oz > ${original_file.baseName}_output.vcf.gz
    """
}