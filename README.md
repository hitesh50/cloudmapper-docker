# cloudmapper-docker

Configures and runs Cloudmapper in a docker container, pointing at a local cloudmapper repository pull, to ensure clean python environment / dependencies. All cloudmapper working files end up by convention in `./cloudmapper` (i.e. `./cloudmapper/account-data/**`, `./cloudmapper/config.json`, `./cloudmapper/data.json`).

## Getting Started

The provided `setup.sh` script pulls the cloudmapper repo into the current directory, and then installs the maxmind geoip data files.

## Usage

### Configure Account

```
docker run -p 8000:8000 -v `pwd`/cloudmapper:/opt/cloudmapper -it cloudmapper configure add-account --name mycorp --id 123456789012 --default true
docker run -p 8000:8000 -v `pwd`/cloudmapper:/opt/cloudmapper -it cloudmapper configure add-cidr --name dev --cidr 1.2.3.4/20'
docker run -p 8000:8000 -v `pwd`/cloudmapper:/opt/cloudmapper -it cloudmapper configure add-cidr --name prod --cidr 2.3.4.5/20'
```

### Collect Account Data

```
docker run -p 8000:8000 -v `pwd`/cloudmapper:/opt/cloudmapper -it cloudmapper collect --account mycorp'
```

### Run Webserver

```
docker run -p 8000:8000 -v `pwd`/cloudmapper:/opt/cloudmapper -it cloudmapper prepare --account mycorp'
docker run -p 8000:8000 -v `pwd`/cloudmapper:/opt/cloudmapper -it cloudmapper webserver --public'
```
