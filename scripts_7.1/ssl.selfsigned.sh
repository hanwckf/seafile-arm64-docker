#!/bin/bash
set -e

ssldir=${1:?"error params"}
domain=${2:?"error params"}

ssl_key=${domain}.key
ssl_crt=${domain}.crt

mkdir -p /var/www/challenges && chmod -R 777 /var/www/challenges
mkdir -p $ssldir

cd $ssldir

if [[ ! -e ${ssl_key} ]]; then
    openssl req -x509 -sha256 -newkey rsa:4096 -keyout ${ssl_key} -out ${ssl_crt} -days 3650 -nodes -subj "/CN=$domain"
fi

nginx -s reload

echo "Nginx reloaded."
