#!/bin/bash
echo "Now in db-setup script"

psql -U postgres --command="CREATE DATABASE ogr_fdw WITH TEMPLATE=template1;" && \
    psql -U postgres --command="CREATE ROLE root WITH LOGIN CREATEDB CREATEROLE;" && \
    psql -U postgres --dbname=ogr_fdw --command="CREATE EXTENSION postgis;" && \
    psql -U postgres --dbname=ogr_fdw --command="CREATE EXTENSION ogr_fdw;" && \
    psql -U postgres --dbname=ogr_fdw --command="CREATE EXTENSION postgres_fdw;"

sed -i 's/local\s\{1,\}all\s\{1,\}postgres\s\{1,\}peer/local all all trust/' /var/lib/postgresql/data/pg_hba.conf
sed -i 's/host\s\{1,\}all\s\{1,\}all\s\{1,\}127.0.0.1\/32\s\{1,\}md5/host all all 127.0.0.1\/32 trust/' /var/lib/postgresql/data/pg_hba.conf
