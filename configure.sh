#!/bin/bash
ghb_usr=$(jq -r .github.user ./config.json)
ghb_tkn=$(jq -r .github.token ./config.json)

tput setaf 6; echo "# Configuring UNITE Pseudonymization Service"; tput sgr0

tput setaf 4; echo "# Logging in to UNITE docker registry"; tput sgr0
echo $ghb_tkn | docker login ghcr.io -u $ghb_usr --password-stdin
echo ""

tput setaf 4; echo "# Creating docker network"; tput sgr0
docker network create ps