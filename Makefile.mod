#!make

all: init up

init:
	mkdir -p initdbmedia initdbnf srv certs
	echo "Dont forget to put your certs file in the certs directory now!"
	echo "Retrieving media files"
	#scp naturalist:backups/media-files.tgz ./srv
	scp check-charlie:/home/ingierli/20180320-migration_naturforskaren/media-files.tgz ./srv
	cd srv && tar xvfz media-files.tgz && rm media-files.tgz
	echo "Retrieving databases - for naturalist ..."
	#scp naturalist:backups/taxonpages_v2.sql ./initdbnf/taxonpages_v2.sql
	scp check-charlie:/home/ingierli/20180320-migration_naturforskaren/taxonpages_v2.sql ./initdbnf/taxonpages_v2.sql
	#scp admin@naturalist.nrm.se:backups/mysql-taxonpages_v2.2018_03_19.sql.gz .
	#gunzip mysql-taxonpages_v2.2018_03_19.sql.gz
	#mv mysql-taxonpages_v2.2018_03_19.sql initdbnf/taxonpages_v2.sql
	echo "... and for mediaserver"
	#scp naturalist:backups/mediaserver_20180319.sql ./initdbmedia/nf_media.sql
	scp check-charlie:/home/ingierli/20180320-migration_naturforskaren/mediaserver_20180319.sql ./initdbmedia/nf_media.sql
	#scp naturalist:backups/update-admin_config.sql ./initdbmedia/update-admin_config.sql
	scp check-charlie:/home/ingierli/20180320-migration_naturforskaren/update-admin_config.sql ./initdbmedia/update-admin_config.sql

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

# See project https://github.com/bioatlas/zoa-docker/blob/master/Makefile 
ssl-certs:
ssl-certs-clean:
ssl-certs-show: