#!/bin/bash

if [ ! -d "images" ]; then
  mkdir images
fi

docker pull --platform linux/amd64 ghcr.io/dkfz-unite/unite-psi:latest
docker pull --platform linux/amd64 medicalinformatics/mainzelliste:1.10-latest
docker pull --platform linux/amd64 postgres:15-alpine
docker save -o images/upsi-front.tar ghcr.io/dkfz-unite/unite-psi:latest
docker save -o images/upsi-back.tar medicalinformatics/mainzelliste:1.10-latest
docker save -o images/upsi-data.tar postgres:15-alpine