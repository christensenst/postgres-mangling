FROM postgres:9.5

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libgdal-dev \
    postgresql-9.5-postgis-2.2 \
    postgresql-server-dev-9.5

WORKDIR /tmp
RUN git clone https://github.com/pramsey/pgsql-ogr-fdw.git
WORKDIR /tmp/pgsql-ogr-fdw
RUN make && make install

# created a symbolic link for ogr_fdw_info
RUN ln -s /usr/lib/postgresql/9.5/bin/ogr_fdw_info /usr/bin/ogr_fdw_info
RUN update-rc.d postgresql defaults

ADD ./db-setup.sh /docker-entrypoint-initdb.d/db-setup.sh
