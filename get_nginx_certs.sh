#!/bin/bash

cp /media/buffalo/dina-data/certs.tar.gpg .
gpg -d certs.tar.gpg > certs.tar
tar xvf certs.tar
rm certs.tar.gpg certs.tar
mkdir -p nginx-certs
cp combined.pem nginx-certs/cert.pem
cp key.pem nginx-certs/cert.key

mkdir -p nginx-conf nginx-html nginx-certs nginx-logs
wget https://raw.githubusercontent.com/DINA-Web/dina_logo/master/favicon.ico -O nginx-html/favicon.ico

