# M. Okun SLAC HPC Linux Eng excercise
# Relion app containerization

FROM docker.io/ubuntu:20.04

ENV DIRPATH=/app
ENV DIRNAME=relion
WORKDIR $DIRPATH/

# non-interactive apt installs
ENV DEBIAN_FRONTEND=noninteractive 

# number of build processes
ENV N_PROCESSES=5

# prereqs
RUN apt-get update
RUN TZ=Etc/UTC apt-get install -y\
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

# clone git repo, branch ver4.0
RUN git clone -b ver4.0 https://github.com/3dem/relion.git

# build
WORKDIR $DIRPATH/$DIRNAME

RUN mkdir build
WORKDIR build

RUN cmake ..
RUN make -j $N_PROCESSES

RUN make install

CMD relion

