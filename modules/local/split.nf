process SPLIT_SITES {
    input: 
    path vcf_file 
    output:
    path "*.txt", emit: input_extract
    path "*_split_fill_nID_nofilter.vcf.gz", emit: file_split

    script:
    def vcf_file_name = vcf_file.toString().replaceAll('.vcf.gz', '')

    """
    bcftools norm -m -both ${vcf_file} -Oz -o split_vcf.vcf.gz
    bcftools +fill-tags split_vcf.vcf.gz -Oz -o split_fill_vcf.vcf.gz -- -t AC,AN,AF
    bcftools annotate --set-id +'%CHROM\\_%POS\\_%REF\\_%ALT' -x FILTER split_fill_vcf.vcf.gz -Oz -o ${vcf_file_name}_split_fill_nID_nofilter.vcf.gz
    echo "CHROM\tPOS\tID\tREF\tALT\tAC\tAN\tAF" > ${vcf_file_name}.txt
    bcftools query -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\t%INFO/AC\t%INFO/AN\t%INFO/AF\n' ${vcf_file_name}_split_fill_nID_nofilter.vcf.gz >> ${vcf_file_name}.txt
    """
}