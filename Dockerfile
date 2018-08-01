FROM ubuntu:xenial

MAINTAINER sridhar <sridhar@wustl.edu>

LABEL docker_image rna_seq_analysis

#dependencies

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    build-essential \
    bzip2 \
    curl \
    g++ \
    git \
    less \
    libcurl4-openssl-dev \
    libpng-dev \
    libssl-dev \
    libxml2-dev \
    make \
    pkg-config \
    rsync \
    unzip \
    wget \
    zip \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    python \
    python-pip \
    python-dev \
    python2.7-dev \
    hdf5-tools \
    libhdf5-dev \
    hdf5-helpers \
    ncurses-dev
    

RUN pip install setuptools && \
    pip install numpy && \
    pip install matplotlib && \
    pip install pandas && \
    pip install scipy && \
    pip install pysam && \
    pip install biopython && \
    pip install seaborn && \
    pip install scikit-learn
    
    
#Create Working Directory
WORKDIR /docker_main
RUN wget https://newcontinuum.dl.sourceforge.net/project/rnaseq-mats/MATS/rMATS.4.0.2.tgz && \
    tar -xzf rMATS.4.0.2.tgz && \
    #cd rMATS.4.0.2/rMATS-turbo-Linux-UCS4 && \
    #chmod +x rMATS_C/rMATSexe
    ln -s /rMATS.4.0.2/rMATS-turbo-Linux-UCS4/* /usr/bin/
    #cp rMATS-turbo-Linux-UCS4/* /usr/bin/



#install samtools
WORKDIR /docker_main
RUN wget https://github.com/samtools/samtools/releases/download/1.4/samtools-1.4.tar.bz2 && \
    tar -jxf samtools-1.4.tar.bz2 && \
    cd samtools-1.4 && \
    make && \
    make install && \
    cp samtools /usr/bin/




# Clean up
RUN cd /docker_main / && \
   rm -rf samtools-1.4 rMATS.4.0.1.tgz && \
   apt-get autoremove -y && \
   apt-get autoclean -y  && \
   apt-get clean
   
# needed for MGI data mounts
RUN apt-get update && apt-get install -y libnss-sss && apt-get clean all

# Set default working path
WORKDIR /docker_main
