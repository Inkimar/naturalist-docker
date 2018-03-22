#!make

all: up

init:
	mkdir -p initdbmedia initdbnf srv certs
	echo "Dont forget to put your certs file in the certs directory now!"
	echo "Retrieving media files"
	scp naturalist:backups/media-files.tgz ./srv
	cd srv && tar xvfz media-files.tgz && rm media-files.tgz
	echo "Retrieving databases - for naturalist ..."
	scp naturalist:backups/taxonpages_v2.sql ./initdbnf/taxonpages_v2.sql
	#scp admin@naturalist.nrm.se:backups/mysql-taxonpages_v2.2018_03_19.sql.gz .
	#gunzip mysql-taxonpages_v2.2018_03_19.sql.gz
	#mv mysql-taxonpages_v2.2018_03_19.sql initdbnf/taxonpages_v2.sql
	echo "... and for mediaserver"
	scp naturalist:backups/mediaserver_20180319.sql ./initdbmedia/nf_media.sql
	scp naturalist:backups/update-admin_config.sql ./initdbmedia/update-admin_config.sql

clean:
	rm -rf initdbmedia initdbnf #srv

up:
	@docker-compose up -d

down:
	@docker-compose down

browse:
	firefox https://beta-naturforskaren.dina-web.net/nf-naturalist/ &
	firefox https://beta-media.dina-web.net/MediaServerRestEasy/ &

dump-media-schema:
	docker exec naturalistdocker_dbmedia_1 \
		mysqldump -u mediaserver -pmediaserver --no-data nf_media > nf_media_schema.sql

DOCKERHUB_VER=v8.1.2
build:
	@docker build -t dina/naturalist_enhanced:${DOCKERHUB_VER} wildfly-custom

# See project https://github.com/bioatlas/zoa-docker/blob/master/Makefile 
ssl-certs:
	@echo "Generating SSL certs using https://hub.docker.com/r/paulczar/omgwtfssl/"
	docker run -v /tmp/certs:/certs \
		-e SSL_SUBJECT=beta-naturforskaren.se \
		-e SSL_DNS=beta-media.naturforskaren.se \
	paulczar/omgwtfssl
	cp /tmp/certs/cert.pem certs/beta-naturforskaren.se.crt
	cp /tmp/certs/key.pem certs/beta-naturforskaren.se.key

	@echo "Using self-signed certificates will require either the CA cert to be imported system-wide or into apps"
	@echo "if you don't do this, apps will fail to request data using SSL (https)"
	@echo "WARNING! You now need to import the /tmp/certs/ca.pem file into Firefox/Chrome etc"
	@echo "WARNING! For curl to work, you need to provide '--cacert /tmp/certs/ca.pem' switch or SSL requests will fail."

ssl-certs-clean:
	rm -f certs/bioatlas.se.crt certs/beta-naturforskaren.sekey
	rm -f /tmp/certs

ssl-certs-show:
	#openssl x509 -in certs/dina-web.net.crt -text
	openssl x509 -noout -text -in certs/beta-naturforskaren.se.crt

