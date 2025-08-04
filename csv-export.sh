#!/bin/bash

# === Settings ===
OLD_CONTAINER_NAME="ps.data"
OLD_DB_NAME="mainzelliste"
OLD_DB_USER="mainzelliste"
OLD_DB_PASS="Defautl32BitDbPassHasToBeChanged"

CONTAINER_EXPORT_DIR="/tmp/db_exports" # Container directory for exports
HOST_EXPORT_DIR="./exports" # Host directory for exports

# === 1: Create folder inside container ===
docker exec "$OLD_CONTAINER_NAME" rm -rf "$CONTAINER_EXPORT_DIR"
docker exec "$OLD_CONTAINER_NAME" mkdir -p "$CONTAINER_EXPORT_DIR"

# === 2: Get list of tables ===
TABLES=$(docker exec -e PGPASSWORD="$OLD_DB_PASS" "$OLD_CONTAINER_NAME" \
  psql -U "$OLD_DB_USER" -d "$OLD_DB_NAME" -Atc \
  "SELECT tablename FROM pg_tables WHERE schemaname='public';")

# === 3: For each table — export to CSV ===
for TABLE in $TABLES; do
  echo "Exporting table: $TABLE"
  docker exec -e PGPASSWORD="$OLD_DB_PASS" "$OLD_CONTAINER_NAME" \
    bash -c "psql -U $OLD_DB_USER -d $OLD_DB_NAME -c \"\\COPY \\\"$TABLE\\\" TO '$CONTAINER_EXPORT_DIR/$TABLE.csv' WITH CSV HEADER\""
done

# === 4: Copy CSV files to host ===
rm -rf "$HOST_EXPORT_DIR"
mkdir -p "$HOST_EXPORT_DIR"
docker cp "$OLD_CONTAINER_NAME":"$CONTAINER_EXPORT_DIR"/. "$HOST_EXPORT_DIR"

echo "Export completed. CSV files copied to $HOST_EXPORT_DIR"