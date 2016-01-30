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
    gdal-bin \
    wget \
    curl \
    vim \
    sudo

