all: build prepare up

clean: stop rm
	sudo chown -R $(ME):$(ME) nginx-conf nginx-html nginx-certs nginx-logs
	sudo chown -R $(ME):$(ME) mysql-datadir mysql-shr mysql-autoload mysql-conf.d

prepare:
	echo "Retrieving databases - for naturalist and mediaserver"
	./get_db_data.sh

	docker-compose up -d db
	docker-compose logs db

	echo "Installing image files"
	./get_fs_data.sh

	echo "Installing app file (.war)"
	./get_war.sh

	echo "Installing nginx certs and DINA favicon"
	./get_nginx_certs.sh
	
build:
	docker-compose build --no-cache as

up:
	docker-compose up -d

	echo "Please make sure you have naturforskaren.dina-web.net in your /etc/hosts!"
	sleep 5
	wget --retry-connrefused --tries=5 --waitretry=6 --no-check-certificate "https://naturforskaren.dina-web.net/naturalist/"

	echo "Opening app!"
	firefox https://naturforskaren.dina-web.net/naturalist/
stop:
	docker-compose stop

rm:
	docker-compose rm -vf

