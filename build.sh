#!/bin/bash
src_pth=$(jq -r .source.path ./config.json)
ghb_usr=$(jq -r .github.user ./config.json)
ghb_tkn=$(jq -r .github.token ./config.json)

tput setaf 6; echo "# Installing UNITE Pseudonymization Service"; tput sgr0

tput setaf 4; echo "# Cleaning up source code directory"; tput sgr0
rm -r -f src
echo ""

tput setaf 4; echo "# Cloning fresh code to source code directory"; tput sgr0
mkdir src
cp -r $src_pth/. src/
echo ""

tput setaf 4; echo "# Building and running docker image"; tput sgr0
GITHUB_USER=$ghb_usr \
GITHUB_TOKEN=$ghb_tkn \
docker compose -p 'ps' -f docker-compose.build.yml up -d --build
