# M. Okun SLAC HPC Linux Eng excercise

# Relion app containerization

# build the relion binary in separate container so we don't package the build env
FROM docker.io/ubuntu:20.04 AS build
ENV DIRPATH=/app
ENV DIRNAME=relion
WORKDIR $DIRPATH/

# number of build processes
ENV N_PROCESES=5

# prereqs
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y\
    tzdata
RUN apt-get install -y\
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

# git repo, branch ver4.0
RUN git clone -b ver4.0 https://github.com/3dem/relion.git

# python conda (optional)
#RUN conda env create -f environment.yml

# build
WORKDIR relion

RUN mkdir build
WORKDIR build

RUN cmake ..
RUN make -j $N_PROCESSES

RUN make install

# COPY . .

