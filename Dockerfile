#FROM docker.io/centos:7
FROM docker.io/ubuntu:20.04
ENV DIRPATH=/app
ENV DIRNAME=relion
WORKDIR $DIRPATH/

# number of build processes
ENV N_PROCESES=5

COPY . .

# prereqs
RUN apt-get update && apt-get install -y\
    cmake\
    git\
    build-essential\
    mpi-default-bin\
    mpi-default-dev\
    libfftw3-dev\
    libtiff-dev\
    libpng-dev\
    ghostscript\
    libxft-dev

# git repo
RUN git clone https://github.com/3dem/relion.git
RUN git checkout ver4.0

# python conda (optional)
#RUN conda env create -f environment.yml

# build
WORKDIR relion

RUN mkdir build
WORKDIR build

RUN cmake ..
RUN make -j $N_PROCESSES
