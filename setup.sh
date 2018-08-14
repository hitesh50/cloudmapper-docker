#!/bin/bash

echo "Cloning Cloudmapper Repo..."
git clone https://github.com/duo-labs/cloudmapper.git

echo "Downloading geoip data..."
mkdir -p cloudmapper/data
cd cloudmapper/data
curl http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz --output GeoLite2-City.tar.gz
tar -zxf GeoLite2-City.tar.gz
mv GeoLite2-City_*/GeoLite2-City.mmdb .
curl http://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN.tar.gz --output GeoLite2-ASN.tar.gz
tar -zxf GeoLite2-ASN.tar.gz
mv GeoLite2-ASN*/GeoLite2-ASN.mmdb .
rm -rf GeoLite2-City_*
rm -rf GeoLite2-ASN_*
rm -rf GeoLite2-*.tar.gz
cd ../..

echo "Building Docker Image..."
docker build -t cloudmapper .

echo 'Usage: docker run -p 8000:8000 -v `pwd`/cloudmapper:/opt/cloudmapper -it cloudmapper'

