#!/bin/bash

tput setaf 6; echo "# Removing upsi containers"; tput sgr0
docker service rm unite_upsi
echo ""

tput setaf 6; echo "# Removing upsi images"; tput sgr0
docker image rm ghcr.io/dkfz-unite/upsi
echo ""
