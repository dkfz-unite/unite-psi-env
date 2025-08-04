#!/bin/bash

# === Settings ===
NEW_CONTAINER_NAME="ps.data"
NEW_DB_NAME="mainzelliste"
NEW_DB_USER="mainzelliste"
NEW_DB_PASS="Defautl32BitDbPassHasToBeChanged"

CONTAINER_IMPORT_DIR="/tmp/db_imports"
HOST_IMPORT_DIR="./exports"  # Path to files on the local machine

# === 1: Copy CSV files to container ===
docker exec "$NEW_CONTAINER_NAME" rm -rf "$CONTAINER_IMPORT_DIR"
docker exec "$NEW_CONTAINER_NAME" mkdir -p "$CONTAINER_IMPORT_DIR"
docker cp "$HOST_IMPORT_DIR"/. "$NEW_CONTAINER_NAME":"$CONTAINER_IMPORT_DIR"

# === 2: Import CSV to tables ===
for FILE in "$HOST_IMPORT_DIR"/*.csv; do
  TABLE=$(basename "$FILE" .csv)
  echo "Importing table: $TABLE"
  docker exec -e PGPASSWORD="$NEW_DB_PASS" "$NEW_CONTAINER_NAME" \
    bash -c "psql -U $NEW_DB_USER -d $NEW_DB_NAME -c \"\\COPY \\\"$TABLE\\\" FROM '$CONTAINER_IMPORT_DIR/$TABLE.csv' WITH CSV HEADER\""
done

echo "Import completed."