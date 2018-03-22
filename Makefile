#!make

all: init up

init:
	mkdir -p initdbmedia initdbnf srv certs
	echo "Dont forget to put your certs file in the certs directory now!"
	#echo "Retrieving media files"
	#scp naturalist:backups/media-files.tgz ./srv
	#cd srv && tar xvfz media-files.tgz && rm media-files.tgz
	echo "Retrieving databases - for naturalist ..."
	#scp naturalist:backups/taxonpages_v2.sql ./initdbnf/taxonpages_v2.sql
	cp /media/buffalo/dina-backups/dina-db/mysql-taxonpages_v2.2018_03_20.sql.gz .
	gunzip mysql-taxonpages_v2.2018_03_20.sql.gz && mv mysql-taxonpages_v2.2018_03_20.sql initdbnf/taxonpages_v2.sql
	#scp admin@naturalist.nrm.se:backups/mysql-taxonpages_v2.2018_03_19.sql.gz .
	#gunzip mysql-taxonpages_v2.2018_03_19.sql.gz
	#mv mysql-taxonpages_v2.2018_03_19.sql initdbnf/taxonpages_v2.sql
	echo "... and for mediaserver"
	#scp naturalist:backups/mediaserver_20180319.sql ./initdbmedia/nf_media.sql
	#scp naturalist:backups/update-admin_config.sql ./initdbmedia/update-admin_config.sql
	#cp nf_media_schema.sql ./initdbmedia/nf_media.sql
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

dump-media-data:
	docker exec naturalistdocker_dbmedia_1 \
		mysqldump -u mediaserver -pmediaserver nf_media > nf_media.sql

show-mediadb-queries:
	docker exec -it naturalistdocker_dbmedia_1 \
		mysqladmin -u root -psupersecret -h 127.0.0.1 -i 1 --verbose processlist;
