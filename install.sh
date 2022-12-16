#!/bin/bash

tput setaf 6; echo "# Installing UNITE Pseudonymization Service Interface"; tput sgr0

tput setaf 4; echo "# Running docker image"; tput sgr0
docker stack deploy --compose-file docker-compose.yml unite