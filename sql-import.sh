#!/bin/bash

NEW_CONTAINER_NAME="ps.data"
NEW_DB_NAME="mainzelliste"
NEW_DB_USER="mainzelliste"
NEW_DB_PASS="Defautl32BitDbPassHasToBeChanged"

cat sql/dump.sql | docker exec -e PGPASSWORD=${NEW_DB_PASS} -i ${NEW_CONTAINER_NAME} psql -U ${NEW_DB_USER} -d ${NEW_DB_NAME}