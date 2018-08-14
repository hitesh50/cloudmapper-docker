FROM python:3.6-stretch

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
  && apt-get install -y autoconf automake libtool python3-dev jq awscli build-essential vim libgeos-c1v5 libgeos-dev

RUN pip install --upgrade pip

RUN cd /opt \
  && git clone https://github.com/duo-labs/cloudmapper.git \
  && cd cloudmapper \
  && pip install -r requirements.txt

RUN cd /opt/cloudmapper \
  && mkdir tmp \
  && cd tmp \
  && curl https://codeload.github.com/matplotlib/basemap/tar.gz/v1.1.0 --output basemap-1.1.0.tar.gz \
  && tar -zxf basemap-1.1.0.tar.gz \
  && cd basemap-1.1.0/ \
  && python setup.py install \
  && cd .. \
  && rm -rf basemap-1.1.0* \
  && cd ..

RUN cd /opt/cloudmapper \
  && mkdir -p data \
  && cd data \
  && curl http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz --output GeoLite2-City.tar.gz \
  && tar -zxf GeoLite2-City.tar.gz \
  && mv GeoLite2-City_*/GeoLite2-City.mmdb . \
  && curl http://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN.tar.gz --output GeoLite2-ASN.tar.gz \
  && tar -zxf GeoLite2-ASN.tar.gz \
  && mv GeoLite2-ASN*/GeoLite2-ASN.mmdb . \
  && rm -rf GeoLite2-City_* \
  && rm -rf GeoLite2-ASN_* \
  && rm -rf GeoLite2-*.tar.gz \
  && cd ..

WORKDIR /opt/cloudmapper

VOLUME /opt/cloudmapper

EXPOSE 8000

ENTRYPOINT ["python", "cloudmapper.py"]

