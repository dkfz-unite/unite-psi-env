#!/bin/bash

if [ ! -d "ssl" ] 
then
  mkdir ssl
fi

cd ssl

if [ -z "$1" ]
then
  echo "Generating ssl certificate for localhost"
  mkcert -key-file upsi-key.pem -cert-file upsi-cert.pem localhost 127.0.0.1 ::1
else
  echo "Generating ssl certificate for '$1'"
  mkcert -key-file upsi-key.pem -cert-file upsi-cert.pem $1 localhost 127.0.0.1 ::1
fi

chmod 600 upsi-key.pem
chmod 600 upsi-cert.pem 

cd ..
