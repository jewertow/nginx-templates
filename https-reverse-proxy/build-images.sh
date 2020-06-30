#!/bin/bash

echo "Generating self-signed ssl certificate for HTTPS reverse proxy..."
docker build -t ssl-certgen:latest -f Dockerfile.certgen .
docker container create --name certgen ssl-certgen
docker container cp certgen:/etc/ssl/private/nginx-selfsigned.key ./nginx-selfsigned.key
docker container cp certgen:/etc/ssl/certs/nginx-selfsigned.crt ./nginx-selfsigned.crt
docker container rm -f certgen

cp nginx-selfsigned.crt https-reverse-proxy/
cp nginx-selfsigned.key https-reverse-proxy/

echo "Building https-reverse-proxy"
docker build -t https-reverse-proxy:latest https-reverse-proxy/

echo "Buildig source-service"
docker build -t source-service:latest source-service/

echo "Building target-service"
docker build -t target-service:latest target-service/

