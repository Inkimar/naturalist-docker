#!make

all: init up

init:
	mkdir -p initdbmedia initdbnf certs srv
	echo "Dont forget to put your certs file in the certs directory now!"
	# cp /home/dina/migration_20180503/media-images-20180327.tar . &&  tar xvf media-images-20180327.tar 
	#./get_occurance-map_files.sh
	echo "Retrieving databases - for naturalist ..."
	cp /home/dina/migration_20180503/taxonpages_v2.sql ./initdbnf/taxonpages_v2.sql
	echo "... and for mediaserver"
	cp /home/dina/migration_20180503/nf_media.sql ./initdbmedia/nf_media.sql
	cp /home/dina/migration_20180503/update-admin_config.sql ./initdbmedia/update-admin_config.sql

clean:
	rm -rf initdbmedia initdbnf #srv

up:
	@docker-compose up -d

down:
	@docker-compose down

browse:
	firefox https://beta-naturforskaren.dina-web.net/nf-naturalist/ &
	firefox https://beta-media.dina-web.net/MediaServerResteasy/ &

dump-media-schema:
	docker exec naturalistdocker_dbmedia_1 \
		mysqldump -u mediaserver -pmediaserver --no-data nf_media > nf_media_schema.sql

dump-media-data:
	docker exec naturalistdocker_dbmedia_1 \
		mysqldump -u mediaserver -pmediaserver nf_media > nf_media.sql

backup-media-files:
	tar cvf /media/buffalo/ingimar/media-images-20180327.tar srv/media/*

show-mediadb-queries:
	docker exec -it naturalistdocker_dbmedia_1 \
		mysqladmin -u root -psupersecret -h 127.0.0.1 -i 1 --verbose processlist;
