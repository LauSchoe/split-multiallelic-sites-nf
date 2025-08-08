# split-multiallelic-sites-nf

A nextflow pipeline to split multiallelic sites.

## Development
```
git clone https://github.com/LauSchoe/split-multiallelic-sites-nf.git
cd split-multiallelic-sites-nf
docker build -t split_multiallelicsites_image . # don't ignore the dot
```

## Run split multiallelic sites
```
nextflow run main.nf -c conf/job.config
```