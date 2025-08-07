FROM ubuntu:22.04
COPY /workflows/environment.yml .

# Install miniconda
RUN apt-get update && apt-get install -y wget
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py39_24.5.0-0-Linux-x86_64.sh -O ~/miniconda.sh && \
/bin/bash ~/miniconda.sh -b -p /opt/conda
ENV PATH=/opt/conda/bin:${PATH}


# install software
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    make \
    libz-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl4-openssl-dev \
    libgsl-dev \
    tabix && \
    apt-get clean 

# install conda & environment
RUN conda update -y conda && \
    conda env update -n root -f environment.yml && \
    conda clean --all

# for bioconda to correctly install bcftools
RUN ln -s /lib/x86_64-linux-gnu/libgsl.so.27 /opt/conda/lib/libgsl.so.25

# install bcftools
ENV BCFTOOLS_VERSION=1.20
WORKDIR "/opt"
RUN wget https://github.com/samtools/bcftools/releases/download/${BCFTOOLS_VERSION}/bcftools-${BCFTOOLS_VERSION}.tar.bz2 && \
    ls -l bcftools-${BCFTOOLS_VERSION}.tar.bz2 && \
    tar xvfj bcftools-${BCFTOOLS_VERSION}.tar.bz2 && \
    cd bcftools-${BCFTOOLS_VERSION} && \
    ./configure && \
    make && \
    make install