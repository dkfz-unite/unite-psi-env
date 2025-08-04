#!/bin/bash

OLD_CONTAINER_NAME="ps.data"
OLD_DB_NAME="mainzelliste"
OLD_DB_USER="mainzelliste"
OLD_DB_PASS="Defautl32BitDbPassHasToBeChanged"

if [ ! -d "sql" ]; then
  mkdir sql
fi

docker exec -e PGPASSWORD=$OLD_DB_PASS -t $OLD_CONTAINER_NAME pg_dump -U $OLD_DB_USER $OLD_DB_NAME > sql/dump.sql