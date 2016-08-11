FROM postgres:9.5

ENV ROOTDIR /usr/local/
ENV GDAL_INSTALL_VERSION 2.1.0
ENV POSTGIS_INSTALL_VERSION 2.2.2

WORKDIR $ROOTDIR/
ADD http://download.osgeo.org/gdal/${GDAL_INSTALL_VERSION}/gdal-${GDAL_INSTALL_VERSION}.tar.gz $ROOTDIR/src/
ADD http://download.osgeo.org/postgis/source/postgis-${POSTGIS_INSTALL_VERSION}.tar.gz $ROOTDIR/src/

#install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libcurl4-gnutls-dev \
    libgeos-dev \
    libproj-dev \
    libxml2-dev \
    libjson-c-dev \
    postgresql-server-dev-9.5 \
    sudo

#build and install GDAL
RUN cd src && tar -xvf gdal-${GDAL_INSTALL_VERSION}.tar.gz && cd gdal-${GDAL_INSTALL_VERSION} && \
    ./configure \
        --with-geos=yes \
        --with-pg \
        --with-curl && \
    make && make install && ldconfig

#build and install postgis
RUN cd src && tar -xvf postgis-${POSTGIS_INSTALL_VERSION}.tar.gz && cd postgis-${POSTGIS_INSTALL_VERSION} && \
    ./configure && \
    make && make install && \
    rm -Rf $ROOTDIR/src/*

#build and install ogr_fdw
RUN git clone https://github.com/pramsey/pgsql-ogr-fdw.git
WORKDIR $ROOTDIR/pgsql-ogr-fdw
RUN make && make install
# created a symbolic link for ogr_fdw_info
RUN ln -s /usr/lib/postgresql/9.5/bin/ogr_fdw_info /usr/bin/ogr_fdw_info
RUN update-rc.d postgresql defaults

ADD ./db-setup.sh /docker-entrypoint-initdb.d/db-setup.sh
