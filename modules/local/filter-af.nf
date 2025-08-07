process FILTER_ALLELE_FREQUENCY {
    input:
    path txt
    output:
    path "*.txt", emit: output_ID_list
    """
    #!/usr/bin/env python
    import pandas as pd
    all=pd.read_csv("${txt}", sep="\t")
    all1=all.sort_values('AF', ascending=False).drop_duplicates('POS').sort_index()
    ID_list=all1["ID"].tolist()
    with open ("${txt.baseName}_ID_list.txt", 'w+') as file:
        data_to_write='\\n'.join(ID_list)
        file.write(data_to_write)

    """
}