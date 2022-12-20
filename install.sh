#!/bin/bash

ghb_usr=""
ghb_tkn=""

tput setaf 6; echo "# Installing UNITE Pseudonymization Service Interface"; tput sgr0

tput setaf 4; echo "# Logging in to UNITE docker registry"; tput sgr0
echo $ghb_tkn | docker login ghcr.io -u $ghb_usr --password-stdin
echo ""

tput setaf 4; echo "# Pulling fresh image from the registry"; tput sgr0
docker pull ghcr.io/dkfz-unite/upsi:latest
echo ""

tput setaf 4; echo "# Running the image"; tput sgr0
docker-compose -p '' -f docker-compose.yml up -d --build
