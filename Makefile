ME=$(USER)
all: build init up


init:
	echo "Retrieving databases - for naturalist and mediaserver"
	./get_naturalist-db_schema.sh

	echo "set up database taxonpages_v2"
	docker-compose up -d db.nf
	#echo "Installing app file (.war)"
	#./get_enhanced-naturalist_war.sh
	#echo "For standalone -Installing the maps"
	#./get_occurance-map_files.sh
	echo "Installing nginx certs and DINA favicon"
	./get_nginx_certs.sh
	
build: fetch-sh
	echo "fetching app file (.war)"
	./get_enhanced-naturalist_war.sh
	echo "builds"
	#docker-compose build --no-cache as
	@docker build -t dina/naturalist:v0.1 wildfly-custom

	#echo "For standalone -Installing image files"
	#./get_fs_data.sh

	echo "Installing nginx certs and DINA favicon"
	./get_nginx_certs.sh

build:
	docker-compose build --no-cache as

fetch-sh:
	@curl --progress -L -s -o wait-for-it.sh \
		https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
		chmod +x wait-for-it.sh
	@test -f wildfly-custom/wait-for-it.sh || \
		mv wait-for-it.sh wildfly-custom/

release:
	docker push  dina/naturalist:v0.1


up:
	docker-compose up -d db.nf
	sleep 15
	docker-compose up -d as
	sleep 10

	#docker exec -it dwsystem_as_1 bash -c 'bin/jboss-cli.sh --connect --command="deploy releases/naturalist.war"'


	docker-compose up -d

	@echo "Local:: Please make sure you have beta-naturforskaren.dina-web.net  in your /etc/hosts!"
	sleep 15

	#echo "Opening app!"
	#firefox https://beta-naturforskaren.dina-web.net/nf-naturalist/&


clean: stop rm
	sudo chown -R $(ME):$(ME) nginx-conf nginx-html nginx-certs nginx-logs
	sudo chown -R $(ME):$(ME) mysql_nf-datadir mysql_nf-shr mysql_nf-autoload mysql_nf-conf.d

stop:
	docker-compose stop

rm:
	docker-compose rm -vf

ps: 
	docker-compose ps

