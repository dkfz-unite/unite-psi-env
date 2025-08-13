#!/bin/bash
tput setaf 6; echo "# Installing UNITE Pseudonymization Service"; tput sgr0

tput setaf 4; echo "# Building and running docker image"; tput sgr0
docker compose -p 'ps' -f docker-compose-db.yml up -d --build
