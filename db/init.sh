#!/bin/bash
set -e

# Create databases
psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE task_management;
    CREATE DATABASE datawarehouse;
EOSQL

# Update pg_hba.conf for external connections
echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf

# Wait a moment for databases to be fully created
sleep 2

# Check if backup files exist and restore them
if [ -f "/docker-entrypoint-initdb.d/backup/task_management.dump" ]; then
    echo "Found task_management_backup.dump, restoring to task_management database..."
    pg_restore -U "$POSTGRES_USER" -d task_management --clean --if-exists /docker-entrypoint-initdb.d/backup/task_management.dump
fi

if [ -f "/docker-entrypoint-initdb.d/backup/datawarehouse.dump" ]; then
    echo "Found datawarehouse.dump, restoring to datawarehouse database..."
    pg_restore -U "$POSTGRES_USER" -d datawarehouse --clean --if-exists /docker-entrypoint-initdb.d/backup/datawarehouse.dump
fi

echo "Database initialization completed successfully!"