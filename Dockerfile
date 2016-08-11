FROM debian:jessie

#### Install system dependencies

RUN apt-get update && apt-get install -y \
    build-essential \
    ca-certificates \
    git \
    python \
    python-dev \
    python-gdal \
    python-pyproj \
    libproj-dev \
    binutils \
    libreadline6-dev \
    zlib1g-dev \
    gdal-bin \
    wget \
    curl \
    vim \
    sudo \
    gdb

# get and unpack the postgres source code
WORKDIR /opt
RUN wget https://ftp.postgresql.org/pub/source/v9.5.0/postgresql-9.5.0.tar.gz
RUN gunzip postgresql-9.5.0.tar.gz
RUN tar xf postgresql-9.5.0.tar
WORKDIR /opt/postgresql-9.5.0

# configure the source tree for good debug options
# see https://wiki.postgresql.org/wiki/Developer_FAQ#What_debugging_features_are_available.3F
RUN ./configure --enable-cassert --enable-debug CFLAGS="-ggdb -Og -fno-omit-frame-pointer"

# build and install
RUN make && make install

# setup postgres
RUN adduser postgres
RUN mkdir /usr/local/pgsql/data
RUN chown postgres /usr/local/pgsql/data
ENV PATH=$PATH:/usr/local/pgsql/bin
USER postgres
