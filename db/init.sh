#!/bin/bash
set -e

# Create databases
psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE sheet_management;
    CREATE DATABASE task_management;
    CREATE DATABASE staging;
    CREATE DATABASE datawarehouse;
EOSQL

# Restore .sql files
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname=sheet_management < /docker-entrypoint-initdb.d/backup/sheet_management_dump.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname=task_management < /docker-entrypoint-initdb.d/backup/task_management.sql
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname=staging < /docker-entrypoint-initdb.d/backup/staging_dump.sql
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname=datawarehouse < /docker-entrypoint-initdb.d/backup/dwh_dump.sql
echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf
