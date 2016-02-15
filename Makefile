ME=$(USER)
all: build prepare up

clean: stop rm
	sudo chown -R $(ME):$(ME) nginx-conf nginx-html nginx-certs nginx-logs
	sudo chown -R $(ME):$(ME) mysql_nf-datadir mysql_nf-shr mysql_nf-autoload mysql_nf-conf.d

init:
	echo "Retrieving databases - for naturalist and mediaserver"
	./get_db_data.sh
	echo "set up database taxonpages_v2"
	docker-compose up -d db.nf
	echo "set up database nf_media"
	docker-compose up -d db.media
	
	echo "Installing app file (.war)"
	./get_war.sh

	echo "Installing image files"
	#./get_fs_data.sh

	echo "Installing nginx certs and DINA favicon"
	./get_nginx_certs.sh
	
build:
	docker-compose build --no-cache as

up:
	docker-compose up -d

	echo "Please make sure you have naturforskaren.dina-web.net in your /etc/hosts!"
	sleep 5
	#wget --retry-connrefused --tries=5 --waitretry=6 --no-check-certificate "https://naturforskaren.dina-web.net/naturalist/"        
	wget --retry-connrefused --tries=5 --waitretry=6 --no-check-certificate "https://naturforskaren.dina-web.net/nf-naturalist/"

	echo "Opening app!"
	#firefox https://naturforskaren.dina-web.net/naturalist/&
	firefox https://naturforskaren.dina-web.net/nf-naturalist/&

stop:
	docker-compose stop

rm:
	docker-compose rm -vf

