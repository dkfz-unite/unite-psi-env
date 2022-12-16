#!/bin/bash

tput setaf 6; echo "# Removing upsi containers"; tput sgr0
docker rm -f upsi
echo ""